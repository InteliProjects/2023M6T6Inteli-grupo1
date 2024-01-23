import Delivery from '../entities/delivery.entity';
import DeliveryRepository from '../repositories/database/delivery.repository';
import DeliveryStatusChangeRepository from '../repositories/database/deliveryStatusChange.repository';
import OrderRepository from '../repositories/database/order.repository';
import SchoolRepository from '../repositories/database/school.repository';
import ShippingCompanyRepository from '../repositories/database/shippingCompany.repository';
import SupplierUserRepository from '../repositories/database/supplierUser.repository';
import { ICondition, IFilter, IOrderCondition, IPagination } from '../utils/queryBuilder/IqueryBuilder.util';
import Service from './service';

export default class DeliveryService extends Service<Delivery, DeliveryRepository> {
    deliveryStatusChangeRepository: DeliveryStatusChangeRepository;
    orderRepository: OrderRepository;
    schoolRepository: SchoolRepository;
    supplierUserRepository: SupplierUserRepository;
    shippingCompanyRepository: ShippingCompanyRepository;

    constructor(
        repository: DeliveryRepository,
        deliveryStatusChangeRepository: DeliveryStatusChangeRepository,
        orderRepository: OrderRepository,
        schoolRepository: SchoolRepository,
        supplierUserRepository: SupplierUserRepository,
        shippingCompanyRepository: ShippingCompanyRepository,
    ) {
        super(repository, Delivery);
        this.deliveryStatusChangeRepository = deliveryStatusChangeRepository;
        this.orderRepository = orderRepository;
        this.schoolRepository = schoolRepository;
        this.supplierUserRepository = supplierUserRepository;
        this.shippingCompanyRepository = shippingCompanyRepository;
    }

    async create(data: Record<string, any>, withoutId?: boolean): Promise<string | number> {
        const result = await super.create(data, withoutId);

        await this.deliveryStatusChangeRepository.create({
            delivery_id: result,
            previous_status_id: null,
            next_status_id: 'CREATED',
        });

        return result;
    }

    async findById(id: string | number): Promise<any> {
        const result = await super.findById(id);
        const statusChanges = await this.deliveryStatusChangeRepository.list({ field: 'delivery_id', value: id });

        const deliveryOrders = this.mapDataToMultCamel(
            await this.orderRepository.listWithSupplier({ field: 'id', value: result.orderId }),
        );
        const schools = this.mapDataToMultCamel(
            await this.schoolRepository.listWithBoard({ field: 'id', value: result.schoolId }),
        );

        return {
            ...result,
            school: schools.find((school: any) => school.id == result.schoolId),
            order: deliveryOrders.find((deliveryOrder: any) => deliveryOrder.id == result.orderId),
            statusChanges,
        };
    }

    async updateById(id: string | number, data: Record<string, any>): Promise<string | number> {
        const entity = await this.findById(id);
        const nextStatusId = data.statusId;
        const result = await super.updateById(id, data);

        if (nextStatusId) {
            await this.deliveryStatusChangeRepository.create({
                delivery_id: id,
                previous_status_id: entity.statusId,
                next_status_id: nextStatusId,
            });
        }

        return result;
    }

    async list(
        filters?: IFilter | undefined,
        orders?: IOrderCondition[] | undefined,
        pagination?: IPagination | undefined,
    ): Promise<any[]> {
        const result = await super.list(filters, orders, pagination);
        const statusChanges = await this.listStatusChange();
        const deliveryOrders = this.mapDataToMultCamel(await this.orderRepository.listWithSupplier());
        const schools = this.mapDataToMultCamel(await this.schoolRepository.listWithBoard());
        const shippingCompanies = this.mapDataToMultCamel(await this.shippingCompanyRepository.list());

        return result.map((delivery) => {
            return {
                ...delivery,
                school: schools.find((school: any) => school.id == delivery.schoolId),
                order: deliveryOrders.find((deliveryOrder: any) => deliveryOrder.id == delivery.orderId),
                statusChanges: statusChanges.filter((status: any) => status.delivery.id == delivery.id),
                shippingCompany: shippingCompanies.find(
                    (shippingCompany: any) => shippingCompany.id == delivery.shippingCompanyId,
                ),
            };
        });
    }

    async listStatusChange(filters?: IFilter, orders?: IOrderCondition[], pagination?: IPagination) {
        return this.mapDataToMultCamel(await this.deliveryStatusChangeRepository.list(filters, orders, pagination));
    }

    async listBySupplier(id: number, conditions?: IFilter) {
        const result = await this.repository.listBySupplier(id, conditions);
        const statusChanges = await this.listStatusChange();
        const deliveryOrders = this.mapDataToMultCamel(await this.orderRepository.listWithSupplier());
        const schools = this.mapDataToMultCamel(await this.schoolRepository.listWithBoard());
        const shippingCompanies = this.mapDataToMultCamel(await this.shippingCompanyRepository.list());

        return result.map((delivery: any) => {
            return {
                ...delivery,
                school: schools.find((school: any) => school.id == delivery.school_id),
                order: deliveryOrders.find((deliveryOrder: any) => deliveryOrder.id == delivery.order_id),
                statusChanges: statusChanges.filter((status: any) => status.delivery.id == delivery.id),
                shippingCompany: shippingCompanies.find(
                    (shippingCompany: any) => shippingCompany.id == delivery.shipping_company_id,
                ),
            };
        });
    }

    listCountBySupplier(id: number, conditions?: IFilter) {
        return this.repository.listCountBySupplier(id, conditions);
    }

    private equalDates(date1: Date, date2: Date): boolean {
        const result =
            date1.getFullYear() === date2.getFullYear() &&
            date1.getMonth() === date2.getMonth() &&
            date1.getDate() === date2.getDate();

        return result;
    }

    private getYearmMonthDay(date: Date): Date {
        const year = date.getFullYear();
        const month = date.getMonth();
        const day = date.getDate();

        return new Date(year, month, day);
    }

    convertStatusChangeToStatusWithDate = (
        statusChanges: { delivery_id: number; moment: Date; next_status_id: string; previous_status_id: string }[],
    ) => {
        const dates: Date[] = [];
        statusChanges.forEach((statusChange) => {
            if (!dates.find((date) => this.equalDates(statusChange.moment, date))) {
                dates.push(this.getYearmMonthDay(statusChange.moment));
            }
        });

        return dates.map((date) => {
            return {
                date,
                notifications: statusChanges
                    .filter((statusChange) => this.equalDates(statusChange.moment, date))
                    .map((statusChange) => {
                        return {
                            deliveryId: statusChange.delivery_id,
                            status: statusChange.next_status_id,
                            moment: statusChange.moment,
                        };
                    }),
            };
        });
    };

    listStatusChanges = async (filters?: IFilter, orders?: IOrderCondition[], pagination?: IPagination) => {
        return this.convertStatusChangeToStatusWithDate(
            await this.deliveryStatusChangeRepository.list(filters, orders, pagination),
        );
    };

    listCountStatusChanges = async (filters?: IFilter) => {
        return this.deliveryStatusChangeRepository.listCount(filters);
    };

    listStatusChangesBySchool = async (id: number, orders?: IOrderCondition[], pagination?: IPagination) => {
        return this.convertStatusChangeToStatusWithDate(
            await this.deliveryStatusChangeRepository.listBySchool(id, orders, pagination),
        );
    };

    listCountStatusChangesBySchool = async (id: number) => {
        return this.deliveryStatusChangeRepository.listCountBySchool(id);
    };

    listStatusChangesByShippingCompany = async (id: number, orders?: IOrderCondition[], pagination?: IPagination) => {
        return this.convertStatusChangeToStatusWithDate(
            await this.deliveryStatusChangeRepository.listByShippingCompany(id, orders, pagination),
        );
    };

    listCountStatusChangesByShippingCompany = async (id: number) => {
        return this.deliveryStatusChangeRepository.listCountByShippingCompany(id);
    };

    listStatusChangesBySupplier = async (id: number, orders?: IOrderCondition[], pagination?: IPagination) => {
        return this.convertStatusChangeToStatusWithDate(
            await this.deliveryStatusChangeRepository.listBySupplier(id, orders, pagination),
        );
    };

    listCountStatusChangesBySupplier = async (id: number) => {
        return this.deliveryStatusChangeRepository.listCountBySupplier(id);
    };
}
