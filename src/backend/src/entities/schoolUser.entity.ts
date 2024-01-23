import Entity from './entity';

export default class SchoolUser extends Entity {
    id: number | null;
    email: string;
    schoolId: number;

    constructor(data: any) {
        super();
        const mappedData = this.mapEntryObj(data);
        this.setId(mappedData.id);
        this.email = mappedData.email;
        this.schoolId = mappedData.schoolId || mappedData.school.id;
    }

    setId(id?: number | string | null) {
        this.id = id ? Number(id) : null;
    }
}
