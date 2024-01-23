import SupplierUserController from '../controllers/supplierUser.controller';
import SupplierUserMiddleware from '../middlewares/supplierUser.middleware';
import APIRouter from './apiRouter';

export default class SupplierUserRouter extends APIRouter<SupplierUserController> {
    supplierUserMiddleware: SupplierUserMiddleware;

    constructor(supplierUserController: SupplierUserController, supplierUserMiddleware: SupplierUserMiddleware) {
        super(supplierUserController);
        this.supplierUserMiddleware = supplierUserMiddleware;
    }

    setRoutes() {
        this.router.post('/login', this.controller.login);
        this.router.post('/', this.controller.create);

        this.router.get('/orders', this.supplierUserMiddleware.verifyTokenAndGetUser, this.controller.listOrders);
        this.router.get(
            '/schoolBoards',
            this.supplierUserMiddleware.verifyTokenAndGetUser,
            this.controller.listSchoolBoardWithSchools,
        );

        this.router.get(
            '/shippingCompanies',
            this.supplierUserMiddleware.verifyTokenAndGetUser,
            this.controller.listShippingCompanies,
        );

        this.router.get(
            '/deliveries',
            this.supplierUserMiddleware.verifyTokenAndGetUser,
            this.controller.listDeliveries,
        );

        this.router.get(
            '/deliveries/statusChanges',
            this.supplierUserMiddleware.verifyTokenAndGetUser,
            this.controller.listStatusChanges,
        );

        this.router.post(
            '/deliveries',
            this.supplierUserMiddleware.verifyTokenAndGetUser,
            this.controller.createDelivery,
        );
    }
}
