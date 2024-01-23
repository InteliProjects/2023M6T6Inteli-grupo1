import AuthApiConnection from './auth.api.connection';

export default class SchoolAuthAPIConnection extends AuthApiConnection {
    constructor(baseUrl: string) {
        super(`${baseUrl}`);
    }
}
