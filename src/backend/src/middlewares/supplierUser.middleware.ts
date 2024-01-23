import { NextFunction, Request, Response } from 'express';
import SupplierUserService from '../services/supplierUser.service';
import ApiError from '../infra/ApiError/ApiError';

export default class SupplierUserMiddleware {
    supplierUserService: SupplierUserService;
    constructor(supplierUserService: SupplierUserService) {
        this.supplierUserService = supplierUserService;
    }

    verifyTokenAndGetUser = async (req: Request, res: Response, next: NextFunction) => {
        const token = req.headers.authorization?.split(' ').pop();

        if (!token) {
            throw new ApiError('Invalid Token', 400, false);
        }

        const tokenReturn = this.supplierUserService.verifyToken(token);

        const supplier = await this.supplierUserService.find({ field: 'id', value: (await tokenReturn).id });

        res.locals.supplier = supplier;

        next();
    };
}
