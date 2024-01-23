import supertest from 'supertest';
import app from '../src/testApp';

describe('[School integration]', () => {
    const prefix = '/schools';
    let token = '';

    beforeAll(async () => {
        await app.config();
        const response = await supertest(app.express).post(`${prefix}/login`).send({
            email: 'login.teste.escola.token@gmail.com',
            password: 'teste123',
        });
        token = response.body.token;
    });

    describe('[login]', () => {
        it('has to login and return a token', async () => {
            const response = await supertest(app.express).post(`${prefix}/login`).send({
                email: 'login.teste.escola.token@gmail.com',
                password: 'teste123',
            });

            expect(response.statusCode).toBe(200);
            expect(response.body.id).toBe(1);
            expect(typeof response.body.token).toBe('string');
        });

        it('has to return an error', async () => {
            const response = await supertest(app.express).post(`${prefix}/login`).send({
                email: 'login.teste.escola.token@gmail.com',
                password: 'teste1234',
            });

            expect(response.statusCode).toBe(400);
            expect(response.body.message).toBe('Invalid credentials');
        });
    });

    describe('[list deliveries]', () => {
        it('has to list deliveries', async () => {
            const response = await supertest(app.express)
                .get(`${prefix}/deliveries`)
                .set('Authorization', token)
                .send();

            expect(response.statusCode).toBe(200);
            expect(!!response.body?.conditions).toBe(true);
            expect(!!response.body?.count).toBe(true);
            expect(!!response.body?.data).toBe(true);
        });

        it('hasnt to list deliveries because auth', async () => {
            const response = await supertest(app.express).get(`${prefix}/deliveries`).send();

            expect(response.statusCode).toBe(400);
        });
    });

    describe('[list Deliveries Status Changes]', () => {
        it('has to return the school Boards', async () => {
            const response = await supertest(app.express)
                .get(`${prefix}/deliveries/statusChanges`)
                .set('Authorization', token)
                .send();

            expect(response.statusCode).toBe(200);
            expect(!!response.body?.conditions).toBe(true);
            expect(!!response.body?.count).toBe(true);
            expect(!!response.body?.data).toBe(true);
        });

        it('hasnt to return the school Boards because auth', async () => {
            const response = await supertest(app.express).get(`${prefix}/deliveries/statusChanges`).send();

            expect(response.statusCode).toBe(400);
        });
    });

    afterAll(async () => {
        await app.close();
    });
});
