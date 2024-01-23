import firebaseSDK from '../connections/sdk/firebase.sdk';
import JWT from '../utils/jwt.util';

export default class UserService {
    static login = async (email: string, password: string) => {
        const userCredential = await firebaseSDK.login(email, password);

        const uid = userCredential.user.uid;
        const splittedUid = uid.split('__');
        const cleanedId = splittedUid.pop();

        return {
            token: JWT.createToken(Number(cleanedId), String(userCredential.user.email), splittedUid),
            roles: splittedUid,
        };
    };

    static validateToken = (token: string) => {
        if (!token) {
            throw Error('Invalid Token');
        }
        return JWT.validateToken(String(token));
    };
}
