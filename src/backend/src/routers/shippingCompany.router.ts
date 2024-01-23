import ShippingCompanyController from '../controllers/shippingCompany.controller';
import APIRouter from './apiRouter';

export default class ShippingCompanyRouter extends APIRouter<ShippingCompanyController> {
    constructor(shippingCompanyController: ShippingCompanyController) {
        super(shippingCompanyController);
    }

    setRoutes() {
        this.router.get('/deliveries/:id', this.controller.getDelivery);
        this.router.patch('/deliveries/:id', this.controller.updateDeliveryStatus);
    }
}
