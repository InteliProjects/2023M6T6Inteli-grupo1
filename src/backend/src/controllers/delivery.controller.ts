import { Request, Response } from 'express';
import Delivery from '../entities/delivery.entity';
import DeliveryService from '../services/delivery.service';
import Controller from './controller';

export default class DeliveryController extends Controller {
    private deliveryService: DeliveryService;

    constructor(deliveryService: DeliveryService) {
        super();
        this.deliveryService = deliveryService;
    }

    list = async (req: Request, res: Response) => {
        const conditions = this.getFiltersOrdersAndPagination(req, ['id']);

        const data = await this.deliveryService.list(conditions.filters, conditions.orders, conditions.pagination);
        const count = await this.deliveryService.listCount(conditions.filters);
        res.json({
            conditions,
            count,
            data,
        });
    };

    findById = async (req: Request, res: Response) => {
        const { id } = req.params;

        const entity = await this.deliveryService.findById(id);

        res.json(entity);
    };

    create = async (req: Request, res: Response) => {
        const entity = new Delivery(req.body);
        const createdEntity = await this.deliveryService.createAndFind(entity);
        res.json(createdEntity);
    };

    updatedById = async (req: Request, res: Response) => {
        const { id } = req.params;

        const entity = await this.deliveryService.updateByIdAndFind(id, req.body);

        res.json(entity);
    };

    deleteById = async (req: Request, res: Response) => {
        const { id } = req.params;

        await this.deliveryService.deleteById(id);

        res.json({
            message: 'deleted',
        });
    };
}
