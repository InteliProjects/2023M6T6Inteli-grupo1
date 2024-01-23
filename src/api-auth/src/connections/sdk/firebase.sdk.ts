import { initializeApp } from 'firebase/app';
import dotenv from 'dotenv';
import 'firebase/auth';
import { UserCredential, getAuth, signInWithEmailAndPassword } from 'firebase/auth';
import firebaseAdmin from 'firebase-admin';

class FirebaseSDK {
    private client;
    private admin;

    constructor(
        firebaseConfig: {
            apiKey: string;
            authDomain: string;
            projectId: string;
            storageBucket: string;
            messagingSenderId: string;
            appId: string;
        },
        firebaseJsonPath: string,
    ) {
        this.client = initializeApp(firebaseConfig);
        this.admin = firebaseAdmin.initializeApp({
            credential: firebaseAdmin.credential.cert(require(firebaseJsonPath)),
        });
    }

    private getAuth() {
        return {
            client: getAuth(this.client),
            admin: this.admin.auth(),
        };
    }

    async login(email: string, password: string): Promise<UserCredential> {
        const auth = this.getAuth();
        console.log(`Trying Login with Firebase client SDK`);
        return signInWithEmailAndPassword(auth.client, email, password);
    }

    async create(userInfo: { email: string; password: string; id: string; roles: string[] }) {
        const auth = this.getAuth();
        return await auth.admin.createUser({
            email: userInfo.email,
            password: userInfo.password,
            uid: `${userInfo.roles.join('__')}__${userInfo.id}`,
        });
    }

    async findByEmail(email: string) {
        return this.getAuth().admin.getUserByEmail(email);
    }

    async delete(uid: string) {
        return this.getAuth().admin.deleteUser(uid);
    }
}

dotenv.config({ path: `${__dirname}/../../../.env` });

const firebaseSDK = new FirebaseSDK(
    {
        apiKey: String(process.env.FIREBASE_API_KEY),
        authDomain: String(process.env.FIREBASE_AUTH_DOMAIN),
        projectId: String(process.env.FIREBASE_PROJECT_ID),
        storageBucket: String(process.env.FIREBASE_STORAGE_BUCKET),
        messagingSenderId: String(process.env.FIREBASE_MESSAGING_SENDER_ID),
        appId: String(process.env.FIREBASE_APP_ID),
    },
    `${__dirname}/../../../firebase.json`,
);

export default firebaseSDK;
