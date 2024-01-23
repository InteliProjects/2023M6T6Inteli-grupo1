import Mapper from './mapper.util';

describe('[oneToMultLayer]', () => {
    it('transform an empty obj', () => {
        expect(Mapper.oneToMultLayer({})).toEqual({});
    });

    it('transform an one layer obj', () => {
        const date = new Date();
        expect(
            Mapper.oneToMultLayer({
                id: 1,
                name: 'testing',
                age: 18,
                created_at: date,
            }),
        ).toEqual({
            id: 1,
            name: 'testing',
            age: 18,
            created_at: date,
        });
    });

    it('transform a multi layer obj', () => {
        const date = new Date();

        expect(
            Mapper.oneToMultLayer({
                id: 1,
                name: 'testing',
                module_id: 1,
                module_name: 'module name!',
                module_course_id: 3,
                module_course_name: 'ES',
                module_course_created_at: date,
                age: 18,
                created_at: date,
            }),
        ).toEqual({
            id: 1,
            name: 'testing',
            module: {
                id: 1,
                name: 'module name!',
                course: {
                    id: 3,
                    name: 'ES',
                    created_at: date,
                },
            },
            age: 18,
            created_at: date,
        });
    });

    it('has to transform a user', () => {
        const date = new Date();

        expect(
            Mapper.oneToMultLayer({
                id: 1,
                name: 'oi',
                email: 'email aqui',
                password: 'senha',
                password_salt: 'hash',
                created_at: date,
                updated_at: '2023-09-06T06:57:33.000Z',
            }),
        ).toEqual({
            id: 1,
            name: 'oi',
            email: 'email aqui',
            password: 'senha',
            password_salt: 'hash',
            created_at: date,
            updated_at: '2023-09-06T06:57:33.000Z',
        });
    });

    it('other cases', () => {
        expect(Mapper.oneToMultLayer(null)).toBe(null);
        expect(Mapper.oneToMultLayer(undefined)).toBe(undefined);
        expect(Mapper.oneToMultLayer(1)).toBe(1);
        const date = new Date();
        expect(Mapper.oneToMultLayer(date)).toBe(date);
    });
});