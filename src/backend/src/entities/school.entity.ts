import Entity from './entity';

export default class School extends Entity {
    id: number | null;
    name: string;
    cep: string;
    complement: string;
    street: string;
    number: number;
    district: string;
    city: string;
    boardId: number;

    constructor(data: any) {
        super();
        const mappedData = this.mapEntryObj(data);
        this.setId(mappedData.id);
        this.name = mappedData.name;
        this.cep = mappedData.cep;
        this.complement = mappedData.complement;
        this.street = mappedData.street;
        this.number = mappedData.number;
        this.district = mappedData.district;
        this.city = mappedData.city;
        this.boardId = mappedData.boardId || mappedData.board?.id;
    }

    setId(id?: number | string | null) {
        this.id = id ? Number(id) : null;
    }
}
