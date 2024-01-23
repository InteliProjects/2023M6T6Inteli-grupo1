import { Request, Response } from 'express';
import UserService from '../services/user.service';

export default class SeducController {
    static login = async (req: Request<any, any, { email: string; password: string }>, res: Response) => {
        try {
            const { email, password } = req.body;

            const loginResult = await UserService.login(email, password);

            if (!loginResult.roles.includes('seduc')) {
                throw Error('Not Valid');
            }

            res.json({ token: loginResult.token });
        } catch (error) {
            console.log(error);
            res.status(400).json({ message: 'Invalid credentials' });
        }
    };

    static validateToken = async (req: Request, res: Response) => {
        try {
            const token = req.headers.authorization;

            const payload = UserService.validateToken(String(token));

            if (!payload.roles.includes('seduc')) {
                throw new Error('Not valid');
            }

            res.json({ id: payload.id, email: payload.email });
        } catch (error) {
            res.status(400).json({ message: 'Invalid Token' });
        }
    };
}
