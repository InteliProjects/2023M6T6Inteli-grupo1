import Order from '../entities/order.entity';
import OrderRepository from '../repositories/database/order.repository';
import { IFilter, IOrderCondition, IPagination } from '../utils/queryBuilder/IqueryBuilder.util';
import Service from './service';

export default class OrderService extends Service<Order, OrderRepository> {
    constructor(repository: OrderRepository) {
        super(repository, Order);
    }

    async listWithSupplier(
        filters?: IFilter | undefined,
        orders?: IOrderCondition[] | undefined,
        pagination?: IPagination | undefined,
    ): Promise<any[]> {
        const result = await this.repository.listWithSupplier(filters, orders, pagination);

        return result;
    }

    getItemsCount = async (filters?: IFilter, orders?: IOrderCondition[], pagination?: IPagination) => {
        return this.mapDataToMultCamel(await this.repository.getItemsCount(filters, orders, pagination));
    };
}
