import SupplierUserController from '../controllers/supplierUser.controller';
import App from '../infra/App';
import SupplierUserMiddleware from '../middlewares/supplierUser.middleware';
import DeliveryRepository from '../repositories/database/delivery.repository';
import DeliveryStatusChangeRepository from '../repositories/database/deliveryStatusChange.repository';
import OrderRepository from '../repositories/database/order.repository';
import SchoolRepository from '../repositories/database/school.repository';
import SchoolBoardRepository from '../repositories/database/schoolBoard.repository';
import ShippingCompanyRepository from '../repositories/database/shippingCompany.repository';
import SupplierUserRepository from '../repositories/database/supplierUser.repository';
import SupplierRecommendationRepository from '../repositories/supplierRecommendation/supplierRecommendation.repository';
import SupplierUserRouter from '../routers/supplierUser.router';
import DeliveryService from '../services/delivery.service';
import OrderService from '../services/order.service';
import SchoolService from '../services/school.service';
import SchoolBoardService from '../services/schoolBoard.service';
import ShippingCompanyService from '../services/shippingCompany.service';
import SupplierUserService from '../services/supplierUser.service';
import JWT from '../utils/jwt/jwt.util';

export default function supplierUserRouterProvider(app: App) {
    const databaseConnection = app.getDbConnection();
    const enviromentVars = app.getEnvironmentVars();
    const service = new SupplierUserService(
        new SupplierUserRepository(databaseConnection),
        new SchoolRepository(app.getDbConnection()),
        new SupplierRecommendationRepository(app.getSupplierRecommendationApiConnection()),
        new JWT(enviromentVars.JWT_PRIV),
    );

    const orderService = new OrderService(new OrderRepository(app.getDbConnection()));
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

    const shippingCompanyService = new ShippingCompanyService(new ShippingCompanyRepository(app.getDbConnection()));

    const router = new SupplierUserRouter(
        new SupplierUserController(
            service,
            orderService,
            schoolService,
            schoolBoardService,
            deliveryService,
            shippingCompanyService,
        ),
        new SupplierUserMiddleware(service),
    );

    router.setRoutes();

    return router;
}
