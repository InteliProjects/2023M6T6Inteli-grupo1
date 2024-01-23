import { Request, Response } from 'express';
import UserService from '../services/user.service';
import firebaseSDK from '../connections/sdk/firebase.sdk';

export default class AdminController {
    static create = async (
        req: Request<any, any, { email: string; password: string; id: string; roles: string[] }>,
        res: Response,
    ) => {
        try {
            const { email, password, id, roles } = req.body;
            const userRecord = await firebaseSDK.create({ email, password, id, roles });
            res.json(userRecord);
        } catch (error) {
            res.status(500).json({ message: error });
        }
    };

    static delete = async (req: Request<any, any, { email: string }>, res: Response) => {
        try {
            const { email } = req.body;
            const userRecord = await firebaseSDK.findByEmail(email);
            await firebaseSDK.delete(userRecord.uid);
            res.json({ message: 'deleted' });
        } catch (error) {
            res.status(500).json({ message: error });
        }
    };
}
