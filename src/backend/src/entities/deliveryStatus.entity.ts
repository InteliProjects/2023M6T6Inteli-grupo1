import Entity from './entity';

export default class DeliveryStatus extends Entity {
    id: number | null;
    name: string;
    category: string;

    constructor(data: any) {
        super();
        const mappedData = this.mapEntryObj(data);

        this.setId(mappedData.id);
        this.name = mappedData.name;
        this.category = mappedData.category;
    }

    setId(id?: number | string | null) {
        this.id = id ? Number(id) : null;
    }
}
