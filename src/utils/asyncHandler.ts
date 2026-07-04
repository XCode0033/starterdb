import { NextFunction, RequestHandler, Request, Response} from "express";


export const asyncHandler = (fn:RequestHandler):RequestHandler => (
    req:Request, res:Response, next:NextFunction
) => {
    return Promise.resolve(fn(req, res, next)).catch(next)
}