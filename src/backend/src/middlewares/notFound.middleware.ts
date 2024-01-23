import { Request, Response } from 'express';

export default function notFoundMiddleware(req: Request, res: Response) {
    res.status(404).json({
        status: 404,
        message: 'Route not Found',
    });
}
