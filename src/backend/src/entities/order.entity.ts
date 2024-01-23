import Entity from './entity';

export default class Order extends Entity {
    id: number | null;
    itemName: string;
    category: string;
    quantity: number;
    supplierId: number;
    createdAt: Date | null;

    constructor(data: any) {
        super();
        const mappedData = this.mapEntryObj(data);
        this.setId(mappedData.id);
        this.itemName = mappedData.itemName;
        this.category = mappedData.category;
        this.quantity = mappedData.quantity;
        this.supplierId = mappedData.supplierId || mappedData.supplier.id;
        this.setCreatedAt(mappedData.createdAt);
    }

    setId(id?: number | string | null) {
        this.id = id ? Number(id) : null;
    }

    setCreatedAt(createdAt?: Date | null) {
        this.createdAt = createdAt ? createdAt : null;
    }
}
