import supertest from 'supertest';
import app from '../src/testApp';

describe('[Seduc integration]', () => {
    const prefix = '/seducUsers';
    let token = '';

    beforeAll(async () => {
        await app.config();
        const response = await supertest(app.express).post(`${prefix}/login`).send({
            email: 'login.teste.token@gmail.com',
            password: 'teste123',
        });
        token = response.body.token;
    });

    describe('[login]', () => {
        it('has to login and return a token', async () => {
            const response = await supertest(app.express).post(`${prefix}/login`).send({
                email: 'login.teste.token@gmail.com',
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
            expect(response.body.message).toBe('Invalid credentials');
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

    describe('[Create Orders]', () => {
        it('has to create order', async () => {
            const response = await supertest(app.express).post(`${prefix}/orders`).set('Authorization', token).send({
                itemName: 'Monitor LG 22 polegadas 144 FPS',
                category: 'Monitores',
                quantity: 5,
                supplierId: 1,
            });

            expect(response.statusCode).toBe(200);
            expect(response.body?.itemName).toBe('Monitor LG 22 polegadas 144 FPS');
            expect(response.body?.category).toBe('Monitores');
            expect(response.body?.quantity).toBe(5);
            expect(response.body?.supplierId).toBe(1);
        });

        it('hasnt to create order because the auth', async () => {
            const response = await supertest(app.express).post(`${prefix}/orders`).send({
                itemName: 'Monitor LG 22 polegadas 144 FPS',
                category: 'Monitores',
                quantity: 5,
                supplierId: 1,
            });

            expect(response.statusCode).toBe(400);
        });
    });

    describe('[Create Suppliers]', () => {
        let supplierId = 0;
        it('has to create supplier', async () => {
            const response = await supertest(app.express).post(`${prefix}/suppliers`).set('Authorization', token).send({
                email: 'lg4@gmail.com',
                name: 'LG 4',
                password: 'teste123',
                cnpj: '04392564000178',
            });

            supplierId = response.body?.id;

            expect(response.statusCode).toBe(200);
            expect(response.body?.email).toBe('lg4@gmail.com');
            expect(response.body?.name).toBe('LG 4');
        });

        it('hasnt to create supplier because the auth', async () => {
            const response = await supertest(app.express).post(`${prefix}/suppliers`).send({
                email: 'lg4@gmail.com',
                name: 'LG 4',
                password: 'teste123',
                cnpj: '04392564000178',
            });

            expect(response.statusCode).toBe(400);
        });

        afterAll(async () => {
            await supertest(app.express).delete(`${prefix}/suppliers/${supplierId}`).set('Authorization', token).send();
        });
    });

    describe('[Delete Suppliers]', () => {
        let supplierId = 0;

        beforeAll(async () => {
            const response = await supertest(app.express).post(`${prefix}/suppliers`).set('Authorization', token).send({
                email: 'lg99@gmail.com',
                name: 'LG 99',
                password: 'teste123',
                cnpj: '04392564000178',
            });

            supplierId = response.body.id;
        });

        it('has to delete supplier', async () => {
            const response = await supertest(app.express)
                .delete(`${prefix}/suppliers/${supplierId}`)
                .set('Authorization', token)
                .send();

            expect(response.statusCode).toBe(200);
        });
        it('hasnt to delete supplier because auth', async () => {
            const response = await supertest(app.express).delete(`${prefix}/suppliers/${supplierId}`).send();

            expect(response.statusCode).toBe(400);
        });

        afterAll(async () => {
            await supertest(app.express).delete(`${prefix}/suppliers/${supplierId}`).set('Authorization', token).send();
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

    describe('[Delete Delivery]', () => {
        let deliveryId = 0;

        beforeAll(async () => {
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

            deliveryId = response.body.id;
        });

        it('has to delete delivery', async () => {
            const response = await supertest(app.express)
                .delete(`${prefix}/deliveries/${deliveryId}`)
                .set('Authorization', token)
                .send();

            expect(response.statusCode).toBe(200);
        });
        it('hasnt to delete delivery because auth', async () => {
            const response = await supertest(app.express).delete(`${prefix}/deliveries/${deliveryId}`).send();

            expect(response.statusCode).toBe(400);
        });

        afterAll(async () => {
            await supertest(app.express)
                .delete(`${prefix}/deliveries/${deliveryId}`)
                .set('Authorization', token)
                .send();
        });
    });

    describe('[list items]', () => {
        it('has to return the orders items list', async () => {
            const response = await supertest(app.express)
                .get(`${prefix}/orders/items`)
                .set('Authorization', token)
                .send();

            expect(response.statusCode).toBe(200);
            expect(!!response.body?.conditions).toBe(true);
            expect(!!response.body?.data).toBe(true);
        });
        it('hasnt to return the orders items list because auth', async () => {
            const response = await supertest(app.express).get(`${prefix}/orders/items`).send();

            expect(response.statusCode).toBe(400);
        });
    });

    describe('[list suppliers]', () => {
        it('has to return the orders items list', async () => {
            const response = await supertest(app.express).get(`${prefix}/suppliers`).set('Authorization', token).send();

            expect(response.statusCode).toBe(200);
            expect(!!response.body?.conditions).toBe(true);
            expect(!!response.body?.count).toBe(true);
            expect(!!response.body?.data).toBe(true);
        });

        it('has to return the orders items list', async () => {
            const response = await supertest(app.express).get(`${prefix}/suppliers`).send();

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

    describe('[predict supplier to schoolBoard]', () => {
        it('has to return the orders items list', async () => {
            const response = await supertest(app.express)
                .get(`${prefix}/schoolBoards/1/suppliers/predict`)
                .set('Authorization', token)
                .send();

            expect(response.statusCode).toBe(200);
            expect(typeof response.body.id).toBe('number');
        });

        it('hasnt to return the orders items list because auth', async () => {
            const response = await supertest(app.express).get(`${prefix}/schoolBoards/1/suppliers/predict`).send();

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
