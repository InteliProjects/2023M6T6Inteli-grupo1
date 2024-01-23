import Mapper from './mapper.util';

describe('[snakeToCamel]', () => {
    it('have to transform a one layer object to snakeCase', () => {
        const date = new Date();

        expect(
            Mapper.snakeToCamel({
                id: 1,
                name: 'test here!',
                cause_of_death: 'testingTooMuch',
                created_at: date,
            }),
        ).toEqual({
            id: 1,
            name: 'test here!',
            causeOfDeath: 'testingTooMuch',
            createdAt: date,
        });
    });

    it('have to transform a multi layer object to snakeCase', () => {
        const date = new Date();

        expect(
            Mapper.snakeToCamel({
                id: 1,
                name: 'test here!',
                current_module: {
                    id: 3,
                    name: 'testingTooMuch',
                    my_module: {
                        id: 4,
                        name: 'testing.... haHaha',
                        created_at: date,
                    },
                },
                created_at: date,
            }),
        ).toEqual({
            id: 1,
            name: 'test here!',
            currentModule: {
                id: 3,
                name: 'testingTooMuch',
                myModule: {
                    id: 4,
                    name: 'testing.... haHaha',
                    createdAt: date,
                },
            },
            createdAt: date,
        });
    });

    it('have to transform an empty object to an empty object', () => {
        expect(Mapper.snakeToCamel({})).toEqual({});
    });

    it('transform an Array to camel', () => {
        const date = new Date();

        expect(
            Mapper.snakeToCamel([
                [
                    {
                        id: 1,
                        name: 'test here!',
                        cause_of_death: 'testingTooMuch',
                        created_at: date,
                    },
                    {
                        id: 2,
                        name: 'test here!',
                        cause_of_death: 'testingTooMuch',
                        created_at: date,
                    },
                ],
            ]),
        ).toEqual([
            [
                {
                    id: 1,
                    name: 'test here!',
                    causeOfDeath: 'testingTooMuch',
                    createdAt: date,
                },
                {
                    id: 2,
                    name: 'test here!',
                    causeOfDeath: 'testingTooMuch',
                    createdAt: date,
                },
            ],
        ]);
    });
    it('have to return createdAt', () => {
        expect(Mapper.snakeToCamel('created_at')).toBe('createdAt');
    });

    it('have to return oneTwoThreeFourFiveSixSeven', () => {
        expect(Mapper.snakeToCamel('one_two_three_four_five_six_seven')).toBe('oneTwoThreeFourFiveSixSeven');
    });

    it('have to return ""', () => {
        expect(Mapper.snakeToCamel('')).toBe('');
    });
});
