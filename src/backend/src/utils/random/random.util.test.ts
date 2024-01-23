import Random from './random.util';

describe('[RANDOM]', () => {
    describe('number', () => {
        it('has to create a handom number between 1 and 3 in 15 times', () => {
            for (let i = 0; i < 15; i++) {
                const number = Random.number(3, 1);
                expect(typeof number).toBe('number');
                expect(number >= 1 && number <= 3).toBe(true);
            }
        });

        it('has to create a handom number between 7 and 11 in 15 times', () => {
            for (let i = 0; i < 15; i++) {
                const number = Random.number(11, 7);
                expect(typeof number).toBe('number');
                expect(number >= 7 && number <= 11).toBe(true);
            }
        });
    });

    describe('string', () => {
        it('has to create a random string that has 5 length in 15 times', () => {
            for (let i = 0; i < 15; i++) {
                const string = Random.string(5);
                expect(typeof string).toBe('string');
                expect(string.length).toBe(5);
            }
        });
    });
});
