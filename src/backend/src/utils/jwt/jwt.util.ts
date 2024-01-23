import jwt from 'jsonwebtoken';

export default class JWT {
    private privKey: string;

    constructor(privKey: string) {
        this.privKey = privKey;
    }

    encode(id: number) {
        return jwt.sign(
            {
                id,
            },
            this.privKey,
        );
    }

    decode(token: string) {
        return jwt.decode(token);
    }

    verifyAndDecode(token: string): { id: number } {
        return jwt.verify(token, this.privKey) as unknown as { id: number };
    }
}
