import { Request, Response } from 'express';
import SupplierUser from '../entities/supplierUser.entity';
import Controller from './controller';
import SupplierUserService from '../services/supplierUser.service';
import OrderService from '../services/order.service';
import SchoolService from '../services/school.service';
import SchoolBoardService from '../services/schoolBoard.service';
import DeliveryService from '../services/delivery.service';
import ApiError from '../infra/ApiError/ApiError';
import ShippingCompanyService from '../services/shippingCompany.service';
import { ICondition, IFilter } from '../utils/queryBuilder/IqueryBuilder.util';

export default class SupplierUserController extends Controller {
    private supplierUserService: SupplierUserService;
    private orderService: OrderService;
    private schoolService: SchoolService;
    private schoolBoardService: SchoolBoardService;
    private deliveryService: DeliveryService;
    private shippingCompanyService: ShippingCompanyService;

    constructor(
        supplierUserService: SupplierUserService,
        orderService: OrderService,
        schoolService: SchoolService,
        schoolBoardService: SchoolBoardService,
        deliveryService: DeliveryService,
        shippingCompanyService: ShippingCompanyService,
    ) {
        super();
        this.supplierUserService = supplierUserService;
        this.orderService = orderService;
        this.schoolService = schoolService;
        this.schoolBoardService = schoolBoardService;
        this.deliveryService = deliveryService;
        this.shippingCompanyService = shippingCompanyService;
    }

    create = async (req: Request, res: Response) => {
        const entity = new SupplierUser(req.body);
        const createdEntity = await this.supplierUserService.createAndFind(entity);
        res.json(createdEntity);
    };

    login = async (req: Request, res: Response) => {
        const { email, password } = req.body;

        const token = await this.supplierUserService.login(email, password);
        const user = await this.supplierUserService.find({ field: 'email', value: email });

        res.json({
            ...user,
            token,
        });
    };

    listOrders = async (req: Request, res: Response) => {
        const conditions = this.getFiltersOrdersAndPagination(req, ['id', 'item_name', 'category']);

        if (conditions.filters) {
            conditions.filters.$AND?.push({ field: 'supplier_id', value: res.locals.supplier.id });
        } else {
            conditions.filters = { $AND: [{ field: 'supplier_id', value: res.locals.supplier.id }] };
        }

        const orders = await this.orderService.list(conditions.filters, conditions.orders, conditions.pagination);
        const count = await this.orderService.listCount(conditions.filters);

        const deliveries = await this.deliveryService.list({
            $IN: { field: 'order_id', value: orders.map((order) => order.id) },
        });

        const data = orders.map((order: any) => {
            const orderDeliveries: any[] = deliveries
                .filter((delivery) => delivery.orderId == order.id)
                .map((delivery) => {
                    delete delivery.order;
                    return delivery;
                });

            order.deliveries = orderDeliveries;

            order.deliveryQtd = orderDeliveries.length;
            order.deliveryCompletedQtd = orderDeliveries.reduce((total, element) => {
                if (element.statusId == 'COMPLETED') {
                    return total + 1;
                }
                return total;
            }, 0);

            return order;
        });

        res.json({
            conditions,
            count,
            data,
        });
    };

    listShippingCompanies = async (req: Request, res: Response) => {
        const conditions = this.getFiltersOrdersAndPagination(req, ['id']);

        const data = await this.shippingCompanyService.list(
            conditions.filters,
            conditions.orders,
            conditions.pagination,
        );
        const count = await this.shippingCompanyService.listCount(conditions.filters);

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

    listDeliveries = async (req: Request, res: Response) => {
        const conditions = this.getFiltersOrdersAndPagination(req, ['name']);

        if (conditions.filters?.$AND) {
            conditions.filters.$AND = conditions.filters?.$AND?.map((condition: any) => {
                if (condition.field && condition.field == 'shipping_company_id') {
                    return { table: 'shipping_company', field: 'id', value: condition.value };
                } else if (condition.field && condition.field == 'school_board_id') {
                    return { table: 'school_board', field: 'id', value: condition.value };
                } else if (condition.field && condition.field == 'school_id') {
                    return { table: 'school', field: 'id', value: condition.value };
                }

                return condition;
            });
        }

        const data = await this.deliveryService.listBySupplier(res.locals.supplier.id, conditions.filters);
        const count = await this.deliveryService.listCountBySupplier(res.locals.supplier.id, conditions.filters);

        res.json({ conditions, count, data });
    };

    createDelivery = async (req: Request, res: Response) => {
        const order = await this.orderService.findById(req.body.orderId);

        if (order.supplierId != res.locals.supplier.id) {
            throw new ApiError('Forbidden', 403, false);
        }

        req.body.statusId = 'CREATED';

        const entity = await this.deliveryService.createAndFind(req.body);
        res.json(entity);
    };

    listStatusChanges = async (req: Request, res: Response) => {
        const id = Number(res.locals.supplier.id);
        const conditions = this.getFiltersOrdersAndPagination(req, ['name']);

        if (!conditions.orders) {
            conditions.orders = [{ field: 'moment', order: 'DESC' }];
        }

        const data = await this.deliveryService.listStatusChangesBySupplier(
            id,
            conditions.orders,
            conditions.pagination,
        );
        const count = await this.deliveryService.listCountStatusChangesBySupplier(id);

        res.json({
            conditions,
            data,
            count,
        });
    };
}
