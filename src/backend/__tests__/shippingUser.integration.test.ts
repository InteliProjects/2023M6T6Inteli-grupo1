import supertest from 'supertest';
import app from '../src/testApp';

describe('[Shipping integration]', () => {
    const prefix = '/shippingCompanies';

    beforeAll(async () => {
        await app.config();
    });

    describe('[find delivery]', () => {
        it('has to find a delivery', async () => {
            const response = await supertest(app.express).get(`${prefix}/deliveries/1`).send();

            expect(response.statusCode).toBe(200);
            expect(response.body.id).toBe(1);
            expect(!!response.body?.school?.id).toBe(true);
            expect(!!response.body?.school?.board?.id).toBe(true);
            expect(!!response.body?.order?.id).toBe(true);
            expect(!!response.body?.order?.supplier?.id).toBe(true);
        });
    });

    describe('[patch delivery]', () => {
        it('has to update to complete a delivery', async () => {
            const response = await supertest(app.express).patch(`${prefix}/deliveries/1`).send({
                status: 'COMPLETED',
                receiptCode: 'lbo0n',
            });

            expect(response.statusCode).toBe(200);
            expect(response.body?.statusId).toBe('COMPLETED');
        }, 15000);

        it('hasnt to update to complete a delivery because of the code', async () => {
            const response = await supertest(app.express).patch(`${prefix}/deliveries/1`).send({
                status: 'COMPLETED',
                receiptCode: 'lbo0nk',
            });

            expect(response.statusCode).toBe(403);
        });
    });

    afterAll(async () => {
        await app.close();
    });
});
