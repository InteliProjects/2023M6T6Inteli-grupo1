import express from 'express';
import SeducController from '../controller/seduc.controller';

const seducRouter = express.Router();

seducRouter.post('/login', SeducController.login);
seducRouter.post('/validateToken', SeducController.validateToken);

export default seducRouter;
