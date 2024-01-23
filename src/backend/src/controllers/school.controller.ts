import { Request, Response } from 'express';
import Controller from './controller';
import SchoolUserService from '../services/schoolUser.service';
import DeliveryService from '../services/delivery.service';
import ApiError from '../infra/ApiError/ApiError';

export default class SchoolController extends Controller {
    private schoolUserService: SchoolUserService;
    private deliveryService: DeliveryService;

    constructor(SchoolUserService: SchoolUserService, deliveryService: DeliveryService) {
        super();
        this.schoolUserService = SchoolUserService;
        this.deliveryService = deliveryService;
    }

    updateDeliveryStatus = async (req: Request, res: Response) => {
        const updateObj: any = { statusId: req.body.status };

        if (updateObj.statusId != 'COMPLETED') {
            throw new ApiError('Status not permitted', 403, false);
        }

        await this.deliveryService.updateById(req.params.id, updateObj);
        const delivery = { ...(await this.deliveryService.findById(req.params.id)) };
        res.json(delivery);
    };

    updateDeliveryRating = async (req: Request, res: Response) => {
        const updateObj: any = { rating: req.body.rating };

        const deliveryPreUpdate = await this.deliveryService.findById(req.params.id);

        if (deliveryPreUpdate.statusId != 'COMPLETED') {
            throw new ApiError('Status not permitted', 403, false);
        }

        if (updateObj.rating > 5 || updateObj.rating < 1) {
            throw new ApiError('Rating out of range', 400, false);
        }

        await this.deliveryService.updateById(req.params.id, updateObj);
        const delivery = { ...(await this.deliveryService.findById(req.params.id)) };
        res.json(delivery);
    };

    getDelivery = async (req: Request, res: Response) => {
        const delivery = { ...(await this.deliveryService.findById(req.params.id)) };
        res.json(delivery);
    };

    login = async (req: Request, res: Response) => {
        const { email, password } = req.body;

        const token = await this.schoolUserService.login(email, password);
        const seducUser = await this.schoolUserService.find({ field: 'email', value: email });

        res.json({ ...seducUser, token });
    };

    listDeliveries = async (req: Request, res: Response) => {
        const conditions = this.getFiltersOrdersAndPagination(req, ['name']);

        if (conditions.filters) {
            conditions.filters.$AND?.push({ field: 'school_id', value: res.locals.school.id });
        } else {
            conditions.filters = { $AND: [{ field: 'school_id', value: res.locals.school.id }] };
        }

        const data = await this.deliveryService.list(conditions.filters, conditions.orders, conditions.pagination);
        const count = await this.deliveryService.listCount(conditions.filters);

        res.json({ conditions, count, data });
    };

    listStatusChanges = async (req: Request, res: Response) => {
        const id = Number(res.locals.school.id);
        const conditions = this.getFiltersOrdersAndPagination(req, ['name']);

        if (!conditions.orders) {
            conditions.orders = [{ field: 'moment', order: 'DESC' }];
        }

        const data = await this.deliveryService.listStatusChangesBySchool(id, conditions.orders, conditions.pagination);
        const count = await this.deliveryService.listCountStatusChangesBySchool(id);

        res.json({
            conditions,
            data,
            count,
        });
    };
}
