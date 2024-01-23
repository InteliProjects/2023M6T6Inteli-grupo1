import Entity from './entity';
import School from './school.entity';

export default class Delivery extends Entity {
    id: number | null;
    orderId: number;
    schoolId: number;
    shippingCompanyId: number;
    quantity: number;
    statusId: string;
    receiptCode: string | null;
    initialForecast: Date;
    finalForecast: Date;
    rating: number | null;
    receivedQuantity: number | null;

    constructor(data: any) {
        super();
        const mappedData = this.mapEntryObj(data);

        this.setId(mappedData.id);
        this.orderId = mappedData.orderId || mappedData.order.id;
        this.schoolId = mappedData.schoolId || mappedData.school.id;
        this.shippingCompanyId = mappedData.shippingCompanyId || mappedData.shipping?.company?.id;
        this.quantity = mappedData.quantity;
        this.statusId = mappedData.statusId || mappedData.status?.id;
        this.receiptCode = mappedData.receiptCode;
        this.initialForecast = mappedData.initialForecast;
        this.finalForecast = mappedData.finalForecast;
        this.rating = mappedData.rating;
        this.receivedQuantity = mappedData.receivedQuantity;
    }

    setId(id?: number | string | null) {
        this.id = id ? Number(id) : null;
    }
}
