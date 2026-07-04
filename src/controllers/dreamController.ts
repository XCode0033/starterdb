import express from 'express';
import { RequestHandler, Request, Response, NextFunction } from 'express';
import { pool } from '../db';
import { ApiError } from '../utils/ApiError';
interface Dream {
    id: number;
    title: string;
    stars: number;
    date: string;
    description: string;
}

type CreateDreamBody = Omit<Dream, "id">;
// type PatchBody = Partial<Omit<Dream, "id">>;
export const getAllDreams:RequestHandler = async (req, res, next) => {
    const result = await pool.query (
        `
        SELECT * FROM dreams
        ORDER BY id ASC
        `);

        res.render("home", {dreams: result.rows});
    
}

export const getDreamById:RequestHandler = async(req, res, next) => {
    const id = Number(req.params.id)

    
    const result = await pool.query (
        `
        SELECT * FROM dreams
        WHERE id = $1
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
        WHERE id = $1
        ` ,[id]

    )

    res.render(`editPage`, {dream: result.rows[0]})
}
export const createDream = async(req:Request<CreateDreamBody>, res:Response, next:NextFunction) => {
    const { title, dream_date, stars, description } = req.body

    const result = await pool.query(
        `
        INSERT INTO dreams (title, dream_date, stars, description)
        VALUES ($1, $2::date + CURRENT_TIME, $3, $4)
        RETURNING *
        `,
        [title, dream_date, stars, description]
    )
    res.redirect('/')
}

export const patchDream = async(req:Request, res:Response, next:NextFunction) => {
    const id = Number(req.params.id) 
    const { title, dream_date, stars, description} = req.body;
    const result = await pool.query (
        `
        UPDATE dreams
        SET title = $1, dream_date = $2, stars = $3, description = $4
        WHERE id = $5
        RETURNING *
        `, [title, dream_date, stars, description]
    )

    if(result.rows.length === 0) {
        throw new ApiError(404,`No dream found by id of ${id}`)
    }
    res.redirect(`/${id}`)
}