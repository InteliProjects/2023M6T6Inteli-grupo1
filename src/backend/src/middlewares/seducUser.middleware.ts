import { NextFunction, Request, Response } from 'express';
import SeducUserService from '../services/seducUser.service';
import ApiError from '../infra/ApiError/ApiError';

export default class SeducUserMiddleware {
    seducUserService: SeducUserService;
    constructor(seducUserService: SeducUserService) {
        this.seducUserService = seducUserService;
    }

    verifyTokenAndGetUser = async (req: Request, res: Response, next: NextFunction) => {
        const token = req.headers.authorization?.split(' ').pop();

        if (!token) {
            throw new ApiError('Invalid Token', 400, false);
        }

        const tokenReturn = await this.seducUserService.verifyToken(token);

        const seducUser = await this.seducUserService.find({ field: 'email', value: tokenReturn.email });

        res.locals.seducUser = seducUser;

        next();
    };
}
