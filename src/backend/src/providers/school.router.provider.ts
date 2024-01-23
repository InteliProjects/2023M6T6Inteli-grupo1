import SchoolController from '../controllers/school.controller';
import App from '../infra/App';
import SchoolUserMiddleware from '../middlewares/schoolUser.middleware';
import SchoolAuthAPIRepository from '../repositories/auth/schoolAuth.api.repository';
import DeliveryRepository from '../repositories/database/delivery.repository';
import DeliveryStatusChangeRepository from '../repositories/database/deliveryStatusChange.repository';
import OrderRepository from '../repositories/database/order.repository';
import SchoolRepository from '../repositories/database/school.repository';
import SchoolUserRepository from '../repositories/database/schoolUser.repository';
import ShippingCompanyRepository from '../repositories/database/shippingCompany.repository';
import SupplierUserRepository from '../repositories/database/supplierUser.repository';
import SchoolRouter from '../routers/school.router';
import DeliveryService from '../services/delivery.service';
import SchoolService from '../services/school.service';
import SchoolUserService from '../services/schoolUser.service';

export default function schoolRouterProvider(app: App) {
    const databaseConnection = app.getDbConnection();

    const schoolUserService = new SchoolUserService(
        new SchoolUserRepository(databaseConnection),
        new SchoolAuthAPIRepository(app.getSchoolAuthConnection()),
    );

    const schoolService = new SchoolService(new SchoolRepository(app.getDbConnection()));

    const router = new SchoolRouter(
        new SchoolController(
            schoolUserService,
            new DeliveryService(
                new DeliveryRepository(app.getDbConnection()),
                new DeliveryStatusChangeRepository(app.getDbConnection()),
                new OrderRepository(app.getDbConnection()),
                new SchoolRepository(app.getDbConnection()),
                new SupplierUserRepository(app.getDbConnection()),
                new ShippingCompanyRepository(app.getDbConnection()),
            ),
        ),

        new SchoolUserMiddleware(schoolUserService, schoolService),
    );

    router.setRoutes();

    return router;
}
