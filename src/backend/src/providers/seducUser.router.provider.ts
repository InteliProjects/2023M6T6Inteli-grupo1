import SupplierRecommendationApiConnection from '../connections/apis/supplierRecommendation/supplierRecommendation.api.connection';
import SeducUserController from '../controllers/seducUser.controller';
import App from '../infra/App';
import SeducUserMiddleware from '../middlewares/seducUser.middleware';
import SeducAuthAPIRepository from '../repositories/auth/seducAuth.api.repository';
import DeliveryRepository from '../repositories/database/delivery.repository';
import DeliveryStatusChangeRepository from '../repositories/database/deliveryStatusChange.repository';
import OrderRepository from '../repositories/database/order.repository';
import SchoolRepository from '../repositories/database/school.repository';
import SchoolBoardRepository from '../repositories/database/schoolBoard.repository';
import SeducUserRepository from '../repositories/database/seducUser.repository';
import ShippingCompanyRepository from '../repositories/database/shippingCompany.repository';
import SupplierUserRepository from '../repositories/database/supplierUser.repository';
import SupplierRecommendationRepository from '../repositories/supplierRecommendation/supplierRecommendation.repository';
import SeducUserRouter from '../routers/seducUser.router';
import DeliveryService from '../services/delivery.service';
import OrderService from '../services/order.service';
import SchoolService from '../services/school.service';
import SchoolBoardService from '../services/schoolBoard.service';
import SeducUserService from '../services/seducUser.service';
import SupplierUserService from '../services/supplierUser.service';
import JWT from '../utils/jwt/jwt.util';

export default function seducUserRouterProvider(app: App) {
    const seducService = new SeducUserService(
        new SeducUserRepository(app.getDbConnection()),
        new SeducAuthAPIRepository(app.getSeducAuthConnection()),
    );

    const orderService = new OrderService(new OrderRepository(app.getDbConnection()));

    const supplierService = new SupplierUserService(
        new SupplierUserRepository(app.getDbConnection()),
        new SchoolRepository(app.getDbConnection()),
        new SupplierRecommendationRepository(app.getSupplierRecommendationApiConnection()),
        new JWT(app.getEnvironmentVars().PRIV_KEY as string),
    );

    const schoolBoardService = new SchoolBoardService(new SchoolBoardRepository(app.getDbConnection()));
    const schoolService = new SchoolService(new SchoolRepository(app.getDbConnection()));

    const deliveryService = new DeliveryService(
        new DeliveryRepository(app.getDbConnection()),
        new DeliveryStatusChangeRepository(app.getDbConnection()),
        new OrderRepository(app.getDbConnection()),
        new SchoolRepository(app.getDbConnection()),
        new SupplierUserRepository(app.getDbConnection()),
        new ShippingCompanyRepository(app.getDbConnection()),
    );

    const router = new SeducUserRouter(
        new SeducUserController(
            seducService,
            orderService,
            supplierService,
            schoolService,
            schoolBoardService,
            deliveryService,
        ),
        new SeducUserMiddleware(seducService),
    );

    router.setRoutes();

    return router;
}
