import { Request, Response } from 'express';
import Order from '../entities/order.entity';
import Controller from './controller';
import OrderService from '../services/order.service';

export default class OrderController extends Controller {
    private orderService: OrderService;

    constructor(orderService: OrderService) {
        super();
        this.orderService = orderService;
    }

    list = async (req: Request, res: Response) => {
        const conditions = this.getFiltersOrdersAndPagination(req, ['id', 'item_name', 'category']);

        const data = await this.orderService.list(conditions.filters, conditions.orders, conditions.pagination);
        const count = await this.orderService.listCount(conditions.filters);
        res.json({
            conditions,
            count,
            data,
        });
    };

    findById = async (req: Request, res: Response) => {
        const { id } = req.params;

        const entity = await this.orderService.findById(id);

        res.json(entity);
    };

    create = async (req: Request, res: Response) => {
        const entity = new Order(req.body);
        const createdEntity = await this.orderService.createAndFind(entity);
        res.json(createdEntity);
    };

    updatedById = async (req: Request, res: Response) => {
        const { id } = req.params;

        const entity = await this.orderService.updateByIdAndFind(id, req.body);

        res.json(entity);
    };

    deleteById = async (req: Request, res: Response) => {
        const { id } = req.params;

        await this.orderService.deleteById(id);

        res.json({
            message: 'deleted',
        });
    };
}
