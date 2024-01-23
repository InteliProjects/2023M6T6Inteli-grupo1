import AuthApi from '../../connections/apis/auth/auth.api.connection';

export default abstract class AuthAPIRepository<AuthConnection extends AuthApi> {
    protected APIConnection: AuthConnection;
    constructor(connection: AuthConnection) {
        this.APIConnection = connection;
    }

    async login(email: string, password: string): Promise<string> {
        const response = await this.APIConnection.login(email, password);
        return response.token;
    }

    async validateToken(token: string): Promise<{ id: number; email: string }> {
        return await this.APIConnection.validateToken(token);
    }
}
