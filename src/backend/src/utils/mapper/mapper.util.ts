export default class Mapper {
    static snakeToCamel(input: any): any {
        if (Array.isArray(input)) {
            return input.map((inputObj) => this.snakeToCamel(inputObj));
        } else if (typeof input == 'object' && input) {
            return this.snakeObjKeysToCamel(input);
        } else if (typeof input == 'string') {
            return this.snakeStringToCamel(input);
        } else {
            return input;
        }
    }

    static snakeStringToCamel(str: string) {
        return str.replace(/_([a-z])/g, function (match, group) {
            return group.toUpperCase();
        });
    }

    static snakeObjKeysToCamel(obj: Record<string, any>): Record<string, any> {
        const result: Record<string, any> = {};
        for (const key in obj) {
            if (obj.hasOwnProperty(key)) {
                const camelKey = this.snakeToCamel(key);
                if (typeof obj[key] == 'object' && obj[key] && !(obj[key] instanceof Date)) {
                    result[camelKey] = this.snakeObjKeysToCamel(obj[key]);
                } else {
                    result[camelKey] = obj[key];
                }
            }
        }
        return result;
    }

    static camelToSnake(input: any): any {
        if (Array.isArray(input)) {
            return input.map((inputObj) => this.camelToSnake(inputObj));
        } else if (typeof input == 'object' && input) {
            return this.camelObjKeysToSnake(input);
        } else if (typeof input == 'string') {
            return this.camelStringToSnake(input);
        } else {
            return input;
        }
    }

    static camelStringToSnake(str: string) {
        return str.replace(/([A-Z])/g, function (match) {
            return '_' + match.toLowerCase();
        });
    }

    static camelObjKeysToSnake(obj: Record<string, any>): Record<string, any> {
        const result: Record<string, any> = {};
        for (const key in obj) {
            if (obj.hasOwnProperty(key)) {
                const camelKey = this.camelToSnake(key);
                if (typeof obj[key] == 'object' && obj[key] && !(obj[key] instanceof Date)) {
                    result[camelKey] = this.camelObjKeysToSnake(obj[key]);
                } else {
                    result[camelKey] = obj[key];
                }
            }
        }
        return result;
    }

    static oneToMultLayer(input: any): any {
        if (Array.isArray(input)) {
            return input.map((inputVal) => this.oneToMultLayer(inputVal));
        } else if (typeof input == 'object' && input && !(input instanceof Date)) {
            return this.oneObjToMultLayer(input);
        } else {
            return input;
        }
    }

    static oneObjToMultLayer(obj: Record<string, any>): Record<string, any> {
        const result: Record<string, any> = {};
        for (const key in obj) {
            if (obj.hasOwnProperty(key)) {
                const value = obj[key];
                const keys = key.split('_');

                let current = result;

                if (keys[keys.length - 1] === 'id') {
                    for (let i = 0; i < keys.length; i++) {
                        const currentKey = keys[i];

                        if (i === keys.length - 1) {
                            current[currentKey] = value;
                        } else {
                            current[currentKey] = current[currentKey] || (current[currentKey] === null ? null : {});
                            current = current[currentKey];
                        }
                    }
                } else {
                    for (let i = 0; i < keys.length; i++) {
                        const currentKey = keys[i];
                        if (typeof current[currentKey] == 'undefined' || typeof current[currentKey] != 'object') {
                            current[keys.splice(i).join('_')] = value;
                            break;
                        } else {
                            current = current[currentKey];
                        }
                    }
                }
            }
        }

        return result;
    }
}
