import SchoolController from '../controllers/school.controller';
import SchoolUserMiddleware from '../middlewares/schoolUser.middleware';
import APIRouter from './apiRouter';

export default class SchoolRouter extends APIRouter<SchoolController> {
    private schoolUserMiddleware: SchoolUserMiddleware;
    constructor(schoolController: SchoolController, schoolUserMiddleware: SchoolUserMiddleware) {
        super(schoolController);
        this.schoolUserMiddleware = schoolUserMiddleware;
    }

    setRoutes() {
        this.router.post('/login', this.controller.login);

        this.router.get('/deliveries', this.schoolUserMiddleware.verifyTokenAndGetUser, this.controller.listDeliveries);
        this.router.get(
            '/deliveries/statusChanges',
            this.schoolUserMiddleware.verifyTokenAndGetUser,
            this.controller.listStatusChanges,
        );
        this.router.patch(
            '/deliveries/:id/status',
            this.schoolUserMiddleware.verifyTokenAndGetUser,
            this.controller.updateDeliveryStatus,
        );
        this.router.patch(
            '/deliveries/:id/rating',
            this.schoolUserMiddleware.verifyTokenAndGetUser,
            this.controller.updateDeliveryRating,
        );
        this.router.get(
            '/deliveries/:id',
            this.schoolUserMiddleware.verifyTokenAndGetUser,
            this.controller.getDelivery,
        );
    }
}
