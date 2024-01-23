import { NextFunction, Request, Response } from 'express';
import SchoolUserService from '../services/schoolUser.service';
import ApiError from '../infra/ApiError/ApiError';
import SchoolService from '../services/school.service';

export default class SchoolUserMiddleware {
    schoolUserService: SchoolUserService;
    schoolService: SchoolService;

    constructor(schoolUserService: SchoolUserService, schoolService: SchoolService) {
        this.schoolUserService = schoolUserService;
        this.schoolService = schoolService;
    }

    verifyTokenAndGetUser = async (req: Request, res: Response, next: NextFunction) => {
        const token = req.headers.authorization?.split(' ').pop();

        if (!token) {
            throw new ApiError('Invalid Token', 400, false);
        }

        const tokenReturn = await this.schoolUserService.verifyToken(token);

        const schoolUser = await this.schoolUserService.find({ field: 'email', value: tokenReturn.email });
        const school = await this.schoolService.findById(schoolUser.schoolId);

        res.locals.schoolUser = schoolUser;
        res.locals.school = school;

        next();
    };
}
