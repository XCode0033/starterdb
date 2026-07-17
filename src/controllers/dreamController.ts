import express from 'express';
import { RequestHandler, Request, Response, NextFunction } from 'express';
import { pool } from '../db';
import { ApiError } from '../utils/ApiError';
interface Dream {
    dream_id: number;
    title: string;
    stars: number;
    dream_date: string;
    description: string;
}

type CreateDreamBody = Omit<Dream, "dream_id">;
// type PatchBody = Partial<Omit<Dream, "dream_id">>;
export const getAllDreams:RequestHandler = async (req, res, next) => {
    // search pieces
    // dream
    const dream_id = req.query.dream_id as string
    const title = req.query.title as string
    const dream_date = req.query.dream_date as string
    const stars = req.query.stars as string
    const description = req.query.description as string
    //tags
    const tag_id = req.query.tag_id as string
    const tag_name = req.query.tag_name as string

    //sort
    const sortBy = (req.query.sortBy as string) || "library_id";
    const sortDir = (req.query.sortDir as string) || "desc";


   let sql = 
    `
        SELECT
        d.dream_id,
        d.title,
        d.dream_date,
        d.stars,
        d.description,
        t.tag_id,
        t.tag_name,
        dt.dreamtag_id
        FROM dreams AS d
        LEFT JOIN dream_tags AS dt
        ON d.dream_id = dt.dream_id
        LEFT JOIN tags as t
        ON t.tag_id = dt.tag_id
        WHERE 1=1
    `
    const values: any[] = []
    let count = 1;

    if(dream_id) {
        sql += ` AND d.dream_id = $${count}`;
        values.push(dream_id);
        count++;
    }
    if(title) {
        sql += ` AND d.title ILIKE $${count}`;
        values.push(`%${title}%`);
        count++
    }
    if(dream_date) {
        sql += ` AND d.dream_date::text ILIKE $${count}`;
        values.push(`%${dream_date}%`);
        count++
    }

    if(stars) {
        sql += ` AND d.stars = $${count}`;
        values.push(stars);
        count++;
    }
    if(description) {
        sql += ` AND d.description ILIKE $${count}`;
        values.push(`%${description}%`);
        count++;
    }

    if(tag_id) {
        sql += ` AND t.tag_id = $${count}`;
        values.push(tag_id);
        count++;
    }
    if(tag_name) {
        sql += ` AND t.tag_name ILIKE $${count}`;
        values.push(`%${tag_name}%`);
        count++;
    }

    const allowedSortFields: Record<string, string> = {
        dream_id: "d.dream_id",
        title: "d.title",
        dream_date: "d.dream_date",
        stars: "d.stars",
        tag_name: "t.tag_name",
        dreamtag_id: "dt.dreamtag_id"
    }

    const allowedSortDirs = ["asc", "desc"];

    const sortColumn = allowedSortFields[sortBy] || "d.dream_id";
    const sortDirection = allowedSortDirs.includes(sortDir.toLowerCase())
        ? sortDir.toUpperCase()
        : "DESC";

    sql += ` ORDER BY ${sortColumn} ${sortDirection}`;

    const result = await pool.query(sql, values)
    res.render("home", {
        dreams: result.rows,
        filters: {
            dream_id,
            title,
            dream_date,
            stars,
            description,
            tag_id,
            tag_name,
            sortBy,
            sortDir

        }
    })
    
}

export const getDreamById:RequestHandler = async(req, res, next) => {
    const id = Number(req.params.id)

    
    const result = await pool.query (
        `
        SELECT * FROM dreams
        WHERE dream_id = $1
        `, [id]
    )

    if(result.rows.length === 0) {
        throw new ApiError(404, `No dream found by id of ${id}`)
    }
    res.render("dreamId", {dream: result.rows[0]});
}

export const getEditPage:RequestHandler = async (req, res, next) => {
    const id = Number(req.params.id)
    const result = await pool.query(
        `
        SELECT * FROM dreams
        WHERE dream_id = $1
        ` ,[id]

    )

    res.render(`editPage`, {dream: result.rows[0]})
}
export const createDream = async(req:Request<CreateDreamBody>, res:Response, next:NextFunction) => {
    const { title, dream_date, stars, description,tag_name } = req.body
    const dreamInsert = await pool.query (
        `
        INSERT INTO dreams(title, dream_date, stars, description)
        VALUES ($1, $2, $3, $4)
        RETURNING dream_id
        `, [title, dream_date, stars, description]
    )
    const dreamId = dreamInsert.rows[0].dream_id;
    for (const tag of tag_name) {
        const tagResult = await pool.query(
            `
            INSERT INTO tags (tag_name)
            VALUES($1)
            RETURNING tag_id
            ` , [tag]
        )
        const tagId = tagResult.rows[0].tag_id;
    
        await pool.query(
            `
            INSERT INTO dream_tags(dream_id, tag_id)
            VALUES($1, $2)
            `, [dreamId, tagId]
        )
    }
    res.redirect('/')
}

export const patchDream = async(req:Request, res:Response, next:NextFunction) => {
    const id = Number(req.params.id) 
    const { title, dream_date, stars, description} = req.body;
   

    const result = await pool.query (
        `
        UPDATE dreams
        SET title = $1, dream_date = $2, stars = $3, description = $4
        WHERE dream_id = $5
        RETURNING *
        `, [title, dream_date, stars, description, id]
    )

    if(result.rows.length === 0) {
        throw new ApiError(404,`No dream found by id of ${id}`)
    }
    
    res.redirect(`/${id}`)
}

export const deleteDream: RequestHandler = async(req, res, next) => {
    const id = Number(req.params.id);
    
    const result = await pool.query(`
        DELETE FROM dreams
        WHERE dream_id = $1
        `, [id]
    )

    if(result.rowCount === 0) {
        console.log(`Could not find dream with id of ${id}`)
        throw new ApiError(404, `No dream found with id of ${id}`)
    }
    console.log(`Dream with id of ${id} deleted!`)
    res.status(200).send(result.rows[0])
}