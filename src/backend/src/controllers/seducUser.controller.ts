import { Request, Response } from 'express';
import Controller from './controller';
import SeducUserService from '../services/seducUser.service';
import OrderService from '../services/order.service';
import Order from '../entities/order.entity';
import SupplierUserService from '../services/supplierUser.service';
import SchoolService from '../services/school.service';
import SchoolBoardService from '../services/schoolBoard.service';
import DeliveryService from '../services/delivery.service';

export default class SeducUserController extends Controller {
    private seducUserService: SeducUserService;
    private orderService: OrderService;
    private supplierService: SupplierUserService;
    private schoolService: SchoolService;
    private schoolBoardService: SchoolBoardService;
    private deliveryService: DeliveryService;

    constructor(
        seducUserService: SeducUserService,
        orderService: OrderService,
        supplierService: SupplierUserService,
        schoolService: SchoolService,
        schoolBoardService: SchoolBoardService,
        deliveryService: DeliveryService,
    ) {
        super();
        this.seducUserService = seducUserService;
        this.orderService = orderService;
        this.supplierService = supplierService;
        this.schoolService = schoolService;
        this.schoolBoardService = schoolBoardService;
        this.deliveryService = deliveryService;
    }

    login = async (req: Request, res: Response) => {
        const { email, password } = req.body;

        const token = await this.seducUserService.login(email, password);
        const seducUser = await this.seducUserService.find({ field: 'email', value: email });

        res.json({ ...seducUser, token });
    };

    listOrders = async (req: Request, res: Response) => {
        const conditions = this.getFiltersOrdersAndPagination(req, ['id', 'item_name', 'category']);

        const data = await this.orderService.list(conditions.filters, conditions.orders, conditions.pagination);
        const count = await this.orderService.listCount(conditions.filters);

        res.json({
            conditions,
            count,
            data,
        });
    };

    listDeliveries = async (req: Request, res: Response) => {
        const conditions = this.getFiltersOrdersAndPagination(req, ['id']);

        const data = await this.deliveryService.list(conditions.filters, conditions.orders, conditions.pagination);
        const count = await this.deliveryService.listCount(conditions.filters);

        res.json({
            conditions,
            count,
            data,
        });
    };

    createDelivery = async (req: Request, res: Response) => {
        const { orderId, schoolId, shippingCompanyId, quantity, initialForecast, finalForecast } = req.body;

        res.json(
            await this.deliveryService.createAndFind({
                orderId,
                schoolId,
                shippingCompanyId,
                quantity,
                initialForecast,
                finalForecast,
                statusId: 'CREATED',
            }),
        );
    };

    deleteDelivery = async (req: Request, res: Response) => {
        const id = req.params.id;

        res.json(await this.deliveryService.deleteById(id));
    };

    getItems = async (req: Request, res: Response) => {
        const conditions = this.getFiltersOrdersAndPagination(req, ['item_name', 'category']);
        const data = await this.orderService.getItemsCount(
            conditions.filters,
            conditions.orders,
            conditions.pagination,
        );

        res.json({
            conditions,
            data,
        });
    };

    createOrder = async (req: Request, res: Response) => {
        const supplierUser = await this.supplierService.findById(req.body.supplierId);
        const order = new Order({ ...req.body, supplier: supplierUser });

        const entity = await this.orderService.createAndFind(order);

        res.json(entity);
    };

    listSuppliers = async (req: Request, res: Response) => {
        const conditions = this.getFiltersOrdersAndPagination(req, ['id', 'email', 'name']);

        const data = await this.supplierService.list(conditions.filters, conditions.orders, conditions.pagination);
        const count = await this.supplierService.listCount(conditions.filters);

        res.json({
            conditions,
            count,
            data,
        });
    };

    listSchoolBoardWithSchools = async (req: Request, res: Response) => {
        const conditions = this.getFiltersOrdersAndPagination(req, ['name']);

        const boards = await this.schoolBoardService.list(conditions.filters, conditions.orders, conditions.pagination);
        const count = await this.schoolBoardService.listCount(conditions.filters);
        const schools = await this.schoolService.list();
        count.schools = { qtd: 0 };

        const boardsWithSchools = boards.map((board) => {
            let boardInfo: any = { ...board };
            boardInfo.schools = schools.filter((school) => school.boardId == (board.id as number));
            count.schools.qtd += boardInfo.schools.length;
            return boardInfo;
        });

        res.json({ conditions, count, data: boardsWithSchools });
    };

    predictSupplier = async (req: Request<{ id: string }>, res: Response) => {
        const id = Number(req.params.id);

        res.json(await this.supplierService.predictPerSchoolBoard(id));
    };

    createSupplier = async (req: Request, res: Response) => {
        res.json(
            await this.supplierService.createAndFind({
                email: req.body.email,
                name: req.body.name,
                password: req.body.password,
            }),
        );
    };

    deleteSupplier = async (req: Request, res: Response) => {
        const id = req.params.id;

        res.json(await this.supplierService.deleteById(id));
    };

    listStatusChanges = async (req: Request, res: Response) => {
        const conditions = this.getFiltersOrdersAndPagination(req, ['name']);

        if (!conditions.orders) {
            conditions.orders = [{ field: 'moment', order: 'DESC' }];
        }

        const data = await this.deliveryService.listStatusChanges(
            conditions.filters,
            conditions.orders,
            conditions.pagination,
        );
        const count = await this.deliveryService.listCountStatusChanges(conditions.filters);

        res.json({
            conditions,
            data,
            count,
        });
    };
}
