import supertest from 'supertest';
import app from '../src/testApp';

describe('[Supplier integration]', () => {
    const prefix = '/supplierUsers';
    let token = '';

    beforeAll(async () => {
        await app.config();

        const response = await supertest(app.express).post(`${prefix}/login`).send({
            email: 'teste@gmail.com',
            password: 'teste123',
        });
        token = response.body.token;
    });

    describe('[login]', () => {
        it('has to login and return a token', async () => {
            const response = await supertest(app.express).post(`${prefix}/login`).send({
                email: 'teste@gmail.com',
                password: 'teste123',
            });

            expect(response.statusCode).toBe(200);
            expect(response.body.id).toBe(1);
            expect(typeof response.body.token).toBe('string');
        });

        it('has to return an error', async () => {
            const response = await supertest(app.express).post(`${prefix}/login`).send({
                email: 'teste@gmail.com',
                password: 'teste1234',
            });

            expect(response.statusCode).toBe(400);
            expect(response.body.message).toBe('Invalid Credentials');
        });
    });

    describe('[list Deliveries]', () => {
        it('has to return the deliveries list', async () => {
            const response = await supertest(app.express)
                .get(`${prefix}/deliveries`)
                .set('Authorization', token)
                .send();

            expect(response.statusCode).toBe(200);
            expect(!!response.body?.conditions).toBe(true);
            expect(!!response.body?.count).toBe(true);
            expect(!!response.body?.data).toBe(true);
        });

        it('hasnt to return the deliveries list because auth', async () => {
            const response = await supertest(app.express).get(`${prefix}/deliveries`).send();

            expect(response.statusCode).toBe(400);
        });
    });

    describe('[Create Deliveries]', () => {
        it('has to create delivery', async () => {
            const response = await supertest(app.express)
                .post(`${prefix}/deliveries`)
                .set('Authorization', token)
                .send({
                    orderId: 1,
                    schoolId: 1,
                    shippingCompanyId: 1,
                    quantity: 5,
                    initialForecast: '2023-12-10',
                    finalForecast: '2023-12-23',
                });

            expect(response.statusCode).toBe(200);
            expect(response.body?.orderId).toBe(1);
            expect(response.body?.schoolId).toBe(1);
            expect(response.body?.shippingCompanyId).toBe(1);
            expect(response.body?.quantity).toBe(5);
        });

        it('hasnt to create delivery because the auth', async () => {
            const response = await supertest(app.express).post(`${prefix}/deliveries`).send({
                orderId: 1,
                schoolId: 1,
                shippingCompanyId: 1,
                quantity: 5,
                initialForecast: '2023-12-10',
                finalForecast: '2023-12-23',
            });

            expect(response.statusCode).toBe(400);
        });
    });

    describe('[list Orders]', () => {
        it('has to return the orders list', async () => {
            const response = await supertest(app.express).get(`${prefix}/orders`).set('Authorization', token).send();

            expect(response.statusCode).toBe(200);
            expect(!!response.body?.conditions).toBe(true);
            expect(!!response.body?.count).toBe(true);
            expect(!!response.body?.data).toBe(true);
        });

        it('hasnt to return the orders list because auth', async () => {
            const response = await supertest(app.express).get(`${prefix}/orders`).send();

            expect(response.statusCode).toBe(400);
        });
    });

    describe('[list schoolBoards]', () => {
        it('has to return the school Boards', async () => {
            const response = await supertest(app.express)
                .get(`${prefix}/schoolBoards`)
                .set('Authorization', token)
                .send();

            expect(response.statusCode).toBe(200);
            expect(!!response.body?.conditions).toBe(true);
            expect(!!response.body?.count).toBe(true);
            expect(!!response.body?.data).toBe(true);
        });

        it('hasnt to return the school Boards because auth', async () => {
            const response = await supertest(app.express).get(`${prefix}/schoolBoards`).send();

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
