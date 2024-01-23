import Mapper from './mapper.util';

describe('[snakeStringToCamel]', () => {
    it('have to return createdAt', () => {
        expect(Mapper.snakeStringToCamel('created_at')).toBe('createdAt');
    });

    it('have to return oneTwoThreeFourFiveSixSeven', () => {
        expect(Mapper.snakeStringToCamel('one_two_three_four_five_six_seven')).toBe('oneTwoThreeFourFiveSixSeven');
    });

    it('have to return ""', () => {
        expect(Mapper.snakeStringToCamel('')).toBe('');
    });
});
