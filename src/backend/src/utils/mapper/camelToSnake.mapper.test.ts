import Mapper from './mapper.util';

describe('[camelToSnake]', () => {
    it('have to transform a one layer object to snakeCase', () => {
        const date = new Date();

        expect(
            Mapper.camelToSnake({
                id: 1,
                name: 'test here!',
                causeOfDeath: 'testingTooMuch',
                createdAt: date,
            }),
        ).toEqual({
            id: 1,
            name: 'test here!',
            cause_of_death: 'testingTooMuch',
            created_at: date,
        });
    });

    it('have to transform a multi layer object to snakeCase', () => {
        const date = new Date();

        expect(
            Mapper.camelToSnake({
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
            }),
        ).toEqual({
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
        });
    });

    it('have to transform an empty object to an empty object', () => {
        expect(Mapper.camelToSnake({})).toEqual({});
    });

    it('transform an Array to snake', () => {
        const date = new Date();

        expect(
            Mapper.camelToSnake([
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
            ]),
        ).toEqual([
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
        ]);
    });
    it('have to return created_at', () => {
        expect(Mapper.camelToSnake('createdAt')).toBe('created_at');
    });

    it('have to return oneTwoThreeFourFiveSixSeven', () => {
        expect(Mapper.camelToSnake('oneTwoThreeFourFiveSixSeven')).toBe('one_two_three_four_five_six_seven');
    });

    it('have to return ""', () => {
        expect(Mapper.camelToSnake('')).toBe('');
    });
});
