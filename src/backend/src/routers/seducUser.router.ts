import SeducUserController from '../controllers/seducUser.controller';
import SeducUserMiddleware from '../middlewares/seducUser.middleware';
import APIRouter from './apiRouter';

export default class SeducUserRouter extends APIRouter<SeducUserController> {
    seducUserMiddleware: SeducUserMiddleware;

    constructor(seducUserController: SeducUserController, seducUserMiddleware: SeducUserMiddleware) {
        super(seducUserController);
        this.seducUserMiddleware = seducUserMiddleware;
    }

    setRoutes() {
        this.router.post('/login', this.controller.login);

        this.router
            .route('/orders')
            .all(this.seducUserMiddleware.verifyTokenAndGetUser)
            .get(this.controller.listOrders)
            .post(this.controller.createOrder);

        this.router.get('/deliveries', this.seducUserMiddleware.verifyTokenAndGetUser, this.controller.listDeliveries);
        this.router.post('/deliveries', this.seducUserMiddleware.verifyTokenAndGetUser, this.controller.createDelivery);
        this.router.delete(
            '/deliveries/:id',
            this.seducUserMiddleware.verifyTokenAndGetUser,
            this.controller.deleteDelivery,
        );

        this.router.get(
            '/deliveries/statusChanges',
            this.seducUserMiddleware.verifyTokenAndGetUser,
            this.controller.listStatusChanges,
        );
        this.router.get('/orders/items', this.controller.getItems);

        this.router.get('/suppliers', this.controller.listSuppliers);
        this.router.post('/suppliers', this.seducUserMiddleware.verifyTokenAndGetUser, this.controller.createSupplier);
        this.router.delete(
            '/suppliers/:id',
            this.seducUserMiddleware.verifyTokenAndGetUser,
            this.controller.deleteSupplier,
        );

        this.router.get(
            '/schoolBoards',
            this.seducUserMiddleware.verifyTokenAndGetUser,
            this.controller.listSchoolBoardWithSchools,
        );

        this.router.get(
            '/schoolBoards/:id/suppliers/predict',
            this.seducUserMiddleware.verifyTokenAndGetUser,
            this.controller.predictSupplier,
        );
    }
}
