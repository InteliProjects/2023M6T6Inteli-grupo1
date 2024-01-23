import ApiError from '../infra/ApiError/ApiError';
import Entity from './entity';

export default class SeducUser extends Entity {
    id: number | null;
    email: string;

    constructor(data: Record<string, any>) {
        super();
        const mappedData = this.mapEntryObj(data);
        this.setId(mappedData.id);
        this.setEmail(mappedData.email);
    }

    setId(id?: number | string | null) {
        this.id = id ? Number(id) : null;
    }

    setEmail(email: string) {
        if (!email || !String(email).includes('@')) {
            throw new ApiError('Malformed email', 500, false);
        }

        this.email = String(email);
    }
}
