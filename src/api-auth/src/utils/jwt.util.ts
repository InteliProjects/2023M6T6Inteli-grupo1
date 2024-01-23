import jwt from 'jsonwebtoken';
import dotenv from 'dotenv';

dotenv.config({ path: `${__dirname}/../.env` });

const privKey: string = process.env.PRIV_KEY as string;

export default class JWT {
    static createToken(userId: number, email: string, roles: string[]) {
        return jwt.sign(
            {
                id: userId,
                email,
                roles,
            },
            privKey,
        );
    }

    static validateToken(token: string): { roles: string[]; id: number; email: string } {
        return jwt.verify(token, privKey) as any;
    }
}
