import Entity from './entity';

export default class DeliveryStatusChange extends Entity {
    deliveryId: number;
    previousStatusId: string | null;
    nextStatusId: string;
    moment: Date;

    constructor(data: any) {
        super();
        const mappedData = this.mapEntryObj(data);

        this.deliveryId = mappedData.deliveryId || mappedData.delivery.id;
        this.nextStatusId = mappedData.nextStatusId || mappedData.nextStatus.id;
        this.previousStatusId = mappedData.previousStatus || mappedData.previousStatus.id;
        this.moment = mappedData.moment;
    }
}
