import Mapper from './mapper.util';

describe('[camelStringToSnake]', () => {
    it('have to return created_at', () => {
        expect(Mapper.camelStringToSnake('createdAt')).toBe('created_at');
    });

    it('have to return oneTwoThreeFourFiveSixSeven', () => {
        expect(Mapper.camelStringToSnake('oneTwoThreeFourFiveSixSeven')).toBe('one_two_three_four_five_six_seven');
    });

    it('have to return ""', () => {
        expect(Mapper.camelStringToSnake('')).toBe('');
    });
});
