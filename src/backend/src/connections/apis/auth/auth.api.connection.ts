import APIConnection from '../api.connection';

export default abstract class AuthApiConnection extends APIConnection {
    constructor(baseUrl: string) {
        super(baseUrl);
    }

    async login(email: string, password: string): Promise<{ token: string }> {
        return this.post('/login', {
            data: {
                email,
                password,
            },
        });
    }

    async validateToken(token: string): Promise<{ id: number; email: string }> {
        return this.post('/validateToken', {
            headers: {
                Authorization: token,
            },
        });
    }
}
