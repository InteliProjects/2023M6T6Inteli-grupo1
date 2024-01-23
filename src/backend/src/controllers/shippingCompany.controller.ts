import { Request, Response } from 'express';
import SupplierUser from '../entities/supplierUser.entity';
import Controller from './controller';
import ShippingCompanyService from '../services/shippingCompany.service';
import DeliveryService from '../services/delivery.service';
import ApiError from '../infra/ApiError/ApiError';
import Random from '../utils/random/random.util';

export default class ShippingCompanyController extends Controller {
    private deliveryService: DeliveryService;
    private shippingCompanyService: ShippingCompanyService;

    constructor(shippingCompanyService: ShippingCompanyService, deliveryService: DeliveryService) {
        super();
        this.shippingCompanyService = shippingCompanyService;
        this.deliveryService = deliveryService;
    }

    updateDeliveryStatus = async (req: Request, res: Response) => {
        const updateObj: any = { statusId: req.body.status };

        if (updateObj.statusId == 'COMPLETED') {
            const delivery = await this.deliveryService.findById(req.params.id);

            if (!delivery.receiptCode) {
                throw new ApiError('Code didnt created', 500);
            } else if (delivery.receiptCode != req.body.receiptCode) {
                throw new ApiError('Wrong Code', 403, false);
            }
        }

        if (updateObj.statusId == 'DELIVERY') {
            updateObj.receipt_code = Random.string(5);
        }
        await this.deliveryService.updateById(req.params.id, updateObj);
        const delivery = { ...(await this.deliveryService.findById(req.params.id)) };

        delete delivery.receiptCode;
        res.json(delivery);
    };

    getDelivery = async (req: Request, res: Response) => {
        const delivery = { ...(await this.deliveryService.findById(req.params.id)) };

        delete delivery.receiptCode;
        res.json(delivery);
    };
}
