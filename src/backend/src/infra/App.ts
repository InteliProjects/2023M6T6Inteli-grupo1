import express from 'express';
import 'express-async-errors';
import dotenv from 'dotenv';
import MysqlConnection from '../connections/database/mysql.database.connection';
import seducUserRouterProvider from '../providers/seducUser.router.provider';
import loggerMiddleware from '../middlewares/logger.middleware';
import errorHandlerMiddleware from '../middlewares/errorHandler.middleware';
import notFoundMiddleware from '../middlewares/notFound.middleware';
import supplierUserRouterProvider from '../providers/supplierUser.router.provider';
import shippingCompanyRouterProvider from '../providers/shippingCompany.router.provider';
import swaggerUi from 'swagger-ui-express';
import schoolRouterProvider from '../providers/school.router.provider';
import fs from 'fs';
import ApiError from './ApiError/ApiError';
import SeducAuthAPIConnection from '../connections/apis/auth/seduc.auth.api';
import SchoolAuthAPIConnection from '../connections/apis/auth/school.auth.api';
import cors from 'cors';
import SupplierRecommendationApiConnection from '../connections/apis/supplierRecommendation/supplierRecommendation.api.connection';

export default class App {
    express: express.Application;
    private port: number;
    private enviromentVars: Record<string, any>;
    private dbConnection?: MysqlConnection;
    private seducAuthConnection?: SeducAuthAPIConnection;
    private schoolAuthConnection?: SchoolAuthAPIConnection;
    private supplierRecommendationConnection?: SupplierRecommendationApiConnection;

    constructor(enviromentVarsPath: string) {
        this.express = express();

        if (!enviromentVarsPath) {
            throw new ApiError('Path to environment vars is necessary', 500);
        }

        dotenv.config({ path: enviromentVarsPath });
        this.enviromentVars = process.env;
        if (!this.enviromentVars.PORT) {
            throw new ApiError('Invalid environment vars', 500);
        }
        this.port = this.enviromentVars.PORT;
    }

    async config() {
        await this.setConnections();
        this.setBeforeMiddlewares();
        this.setRouters();
        this.setAfterMiddlewares();
    }

    private async setConnections() {
        await this.setDBConnection();
        this.setAuthAPIsConnection();
        this.setSupplierRecommendationApiConnection();
    }

    private async setAuthAPIsConnection() {
        this.seducAuthConnection = new SeducAuthAPIConnection(this.enviromentVars.SEDUC_AUTH_API_BASE_URL);
        this.schoolAuthConnection = new SchoolAuthAPIConnection(this.enviromentVars.SCHOOL_AUTH_API_BASE_URL);
    }

    private async setSupplierRecommendationApiConnection() {
        this.supplierRecommendationConnection = new SupplierRecommendationApiConnection(this.enviromentVars.SUPPLIER_RECOMMENDATION_API_BASE_URL);
    }

    private async setDBConnection() {
        const connection = new MysqlConnection(
            this.enviromentVars.DB_HOST,
            this.enviromentVars.DB_USER,
            this.enviromentVars.DB_PASSWORD,
            this.enviromentVars.DB_DATABASE,
            this.enviromentVars.DB_PORT,
        );

        await connection.connect();

        this.dbConnection = connection;
    }

    getEnvironmentVars() {
        return this.enviromentVars;
    }

    getDbConnection() {
        return this.dbConnection as MysqlConnection;
    }

    getSeducAuthConnection() {
        return this.seducAuthConnection as SeducAuthAPIConnection;
    }

    getSchoolAuthConnection() {
        return this.schoolAuthConnection as SchoolAuthAPIConnection;
    }

    getSupplierRecommendationApiConnection() {
        return this.supplierRecommendationConnection as SupplierRecommendationApiConnection;
    }

    private setBeforeMiddlewares() {
        this.express.use(express.json());
        this.express.use(cors());
        this.express.use(loggerMiddleware);
        this.applySwagger();
    }

    private setAfterMiddlewares() {
        this.express.use(errorHandlerMiddleware);
        this.express.use(notFoundMiddleware);
    }

    private setRouters() {
        this.setRouter(seducUserRouterProvider, '/seducUsers');
        this.setRouter(supplierUserRouterProvider, '/supplierUsers');
        this.setRouter(shippingCompanyRouterProvider, '/shippingCompanies');
        this.setRouter(schoolRouterProvider, '/schools');
    }

    private setRouter(routerProvider: CallableFunction, path = '/') {
        const routerClass = routerProvider(this);
        this.express.use(path, routerClass.router);
    }

    private applySwagger() {
        const swaggerDocument = fs.readFileSync(`${__dirname}/../swagger.json`);
        this.express.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerDocument));
    }

    listen() {
        this.express.listen(this.port, () => {
            console.log(`API listen ${this.port} port`);
        });
    }

    async close() {
        if (this.dbConnection) {
            await this.dbConnection.close();
        }
    }
}
