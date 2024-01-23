import express from 'express';
import AdminController from '../controller/admin.controller';

const adminRouter = express.Router();

adminRouter.post('/', AdminController.create);
adminRouter.delete('/', AdminController.delete);

export default adminRouter;
