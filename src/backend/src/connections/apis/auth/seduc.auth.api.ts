import AuthApiConnection from './auth.api.connection';

export default class SeducAuthAPIConnection extends AuthApiConnection {
    constructor(baseUrl: string) {
        super(`${baseUrl}`);
    }
}
