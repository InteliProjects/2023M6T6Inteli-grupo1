import express from 'express';
import Controller from '../controllers/controller';

export default class APIRouter<controllerRouter extends Controller> {
    protected router: express.Router;
    protected controller: controllerRouter;

    constructor(controller: controllerRouter) {
        this.router = express.Router();
        this.controller = controller;
    }
}
