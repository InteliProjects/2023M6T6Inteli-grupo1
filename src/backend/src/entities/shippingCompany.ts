import Entity from './entity';

export default class ShippingCompany extends Entity {
    id: number | null;
    name: string;

    constructor(data: any) {
        super();
        const mappedData = this.mapEntryObj(data);
        this.setId(mappedData.id);
        this.name = mappedData.name;
    }

    setId(id?: number | string | null) {
        this.id = id ? Number(id) : null;
    }
}
