export default class Random {
    static number(max: number = 100, min: number = 0) {
        const result = Math.floor(Math.random() * (max - min + 1)) + min;

        return result;
    }

    static string(length: number = 5, values: string = 'abcdefghijklmnopqrstuvwxyz1234567890') {
        let randomString = '';
        for (let i = 0; i < length; i++) {
            randomString = randomString.concat(values[this.number(values.length - 1)]);
        }

        return randomString;
    }
}
