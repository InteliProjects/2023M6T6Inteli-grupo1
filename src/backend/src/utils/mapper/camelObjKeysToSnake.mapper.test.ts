import Mapper from './mapper.util';

describe('[camelObjKeysToSnake]', () => {
    it('have to transform a one layer object to snakeCase', () => {
        const date = new Date();

        expect(
            Mapper.camelObjKeysToSnake({
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
            Mapper.camelObjKeysToSnake({
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
        expect(Mapper.camelObjKeysToSnake({})).toEqual({});
    });
});
