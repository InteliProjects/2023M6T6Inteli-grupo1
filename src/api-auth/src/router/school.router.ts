import express from 'express';
import SchoolController from '../controller/school.controller';

const schoolRouter = express.Router();

schoolRouter.post('/login', SchoolController.login);
schoolRouter.post('/validateToken', SchoolController.validateToken);

export default schoolRouter;
