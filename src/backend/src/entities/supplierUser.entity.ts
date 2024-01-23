import Entity from './entity';

export default class SupplierUser extends Entity {
    id: number | null;
    email: string;
    password: string;
    name: string;

    constructor(data: any) {
        super();
        const mappedData = this.mapEntryObj(data);
        this.setId(mappedData.id);
        this.email = mappedData.email;
        this.password = mappedData.password;
        this.name = mappedData.name;
    }

    setId(id?: number | string | null) {
        this.id = id ? Number(id) : null;
    }
}
