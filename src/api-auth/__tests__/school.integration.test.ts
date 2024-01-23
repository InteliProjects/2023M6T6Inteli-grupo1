import { describe, expect, it } from '@jest/globals';
import supertest from 'supertest';
import app from '../src';

describe('Testing School Auth Rotes', () => {
    const baseUrl = '/school/';

    beforeAll(async () => {
        await supertest(app)
            .post('/admin/')
            .send({
                email: 'testeintegracao3@gmail.com',
                password: 'teste123',
                roles: ['school'],
                id: 111111,
            });

        await supertest(app)
            .post('/admin/')
            .send({
                email: 'testeintegracao4@gmail.com',
                password: 'teste123',
                roles: ['seduc'],
                id: 222222,
            });
    });

    describe('Testing School Login', () => {
        it('Should login and return a token', async () => {
            const response = await supertest(app).post(`${baseUrl}login`).send({
                email: 'testeintegracao3@gmail.com',
                password: 'teste123',
            });

            expect(response.statusCode).toBe(200);
            expect(typeof response.body.token).toBe('string');
        });

        it('Shouldnt login and should return an error (user not found)', async () => {
            const response = await supertest(app).post(`${baseUrl}login`).send({
                email: 'testeintegracao5@gmail.com',
                password: 'teste123',
            });

            expect(response.statusCode).toBe(400);
            expect(typeof response.body.message).toBe('string');
            expect(response.body.message).toBe('Invalid credentials');
        });

        it('Shouldnt login and should return an error (user not school)', async () => {
            const response = await supertest(app).post(`${baseUrl}login`).send({
                email: 'testeintegracao4@gmail.com',
                password: 'teste123',
            });

            expect(response.statusCode).toBe(400);
            expect(typeof response.body.message).toBe('string');
            expect(response.body.message).toBe('Invalid credentials');
        });
    });

    describe('Testing School Login', () => {
        let tokenOk = '';
        let tokenNotOk = '';
        beforeAll(async () => {
            tokenOk = (
                await supertest(app).post(`${baseUrl}login`).send({
                    email: 'testeintegracao3@gmail.com',
                    password: 'teste123',
                })
            ).body.token;

            tokenNotOk = (
                await supertest(app).post(`/seduc/login`).send({
                    email: 'testeintegracao4@gmail.com',
                    password: 'teste123',
                })
            ).body.token;
        });

        it('Should validate and return user info', async () => {
            const response = await supertest(app)
                .post(`${baseUrl}validateToken`)
                .set('Authorization', await tokenOk)
                .send();

            expect(response.statusCode).toBe(200);
            expect(typeof response.body.id).toBe('number');
            expect(response.body.id).toBe(111111);
            expect(typeof response.body.email).toBe('string');
            expect(response.body.email).toBe('testeintegracao3@gmail.com');
        });

        it('Shouldnt validate (user not found)', async () => {
            const response = await supertest(app).post(`${baseUrl}validateToken`).set('Authorization', 'asdasds').send({
                email: 'testeintegracao5@gmail.com',
                password: 'teste123',
            });

            expect(response.statusCode).toBe(400);
            expect(typeof response.body.message).toBe('string');
            expect(response.body.message).toBe('Invalid Token');
        });

        it('Shouldnt validate (user not school)', async () => {
            const response = await supertest(app)
                .post(`${baseUrl}validateToken`)
                .set('Authorization', await tokenNotOk)
                .send({
                    email: 'testeintegracao5@gmail.com',
                    password: 'teste123',
                });

            expect(response.statusCode).toBe(400);
            expect(typeof response.body.message).toBe('string');
            expect(response.body.message).toBe('Invalid Token');
        });
    });

    afterAll(async () => {
        await supertest(app).delete('/admin/').send({
            email: 'testeintegracao3@gmail.com',
        });

        await supertest(app).delete('/admin/').send({
            email: 'testeintegracao4@gmail.com',
        });
    });
});
