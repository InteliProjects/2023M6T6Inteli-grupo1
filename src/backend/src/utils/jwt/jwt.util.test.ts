import JWT from './jwt.util';
import jsonwebtoken from 'jsonwebtoken';

describe('[JWT]', () => {
    let jwt = new JWT('teste');

    test('[encode]', () => {
        const token = jwt.encode(1);
        expect(token).toBe(jsonwebtoken.sign({ id: 1 }, 'teste'));
        expect(token).toBe(jsonwebtoken.sign({ id: 1 }, 'teste'));
        expect(token).not.toBe(jsonwebtoken.sign({ id: 2 }, 'teste'));
    });

    test('[decode]', () => {
        const token = jwt.encode(1);
        const newJWT = new JWT('teste2');
        expect((jwt.decode(token) as { id: number }).id).toBe(1);
        expect(jwt.decode(token)).toEqual(newJWT.decode(token));
    });

    test('[verifyAndDecode]', () => {
        const token = jwt.encode(1);
        const newJWT = new JWT('teste2');

        expect((jwt.verifyAndDecode(token) as { id: number }).id).toBe(1);
        expect(() => {
            newJWT.verifyAndDecode(token);
        }).toThrow();
    });
});
