import crypto from 'crypto';

export default class Encoding {
    static password = (password: string) => {
        const hash = crypto.createHash('sha256');
        hash.update(password);
        return hash.digest('hex');
    };
}
