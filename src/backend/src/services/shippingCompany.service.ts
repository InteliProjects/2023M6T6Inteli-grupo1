import Service from './service';
import ShippingCompany from '../entities/shippingCompany';
import ShippingCompanyRepository from '../repositories/database/shippingCompany.repository';

export default class ShippingCompanyService extends Service<ShippingCompany, ShippingCompanyRepository> {
    constructor(repository: ShippingCompanyRepository) {
        super(repository, ShippingCompany);
    }
}
