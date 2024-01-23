import ShippingCompanyController from '../controllers/shippingCompany.controller';
import App from '../infra/App';
import DeliveryRepository from '../repositories/database/delivery.repository';
import DeliveryStatusChangeRepository from '../repositories/database/deliveryStatusChange.repository';
import OrderRepository from '../repositories/database/order.repository';
import SchoolRepository from '../repositories/database/school.repository';
import ShippingCompanyRepository from '../repositories/database/shippingCompany.repository';
import SupplierUserRepository from '../repositories/database/supplierUser.repository';
import ShippingCompanyRouter from '../routers/shippingCompany.router';
import DeliveryService from '../services/delivery.service';
import ShippingCompanyService from '../services/shippingCompany.service';

export default function shippingCompanyRouterProvider(app: App) {
    const router = new ShippingCompanyRouter(
        new ShippingCompanyController(
            new ShippingCompanyService(new ShippingCompanyRepository(app.getDbConnection())),
            new DeliveryService(
                new DeliveryRepository(app.getDbConnection()),
                new DeliveryStatusChangeRepository(app.getDbConnection()),
                new OrderRepository(app.getDbConnection()),
                new SchoolRepository(app.getDbConnection()),
                new SupplierUserRepository(app.getDbConnection()),
                new ShippingCompanyRepository(app.getDbConnection()),
            ),
        ),
    );

    router.setRoutes();

    return router;
}
