import Mapper from '../utils/mapper/mapper.util';

export default abstract class Entity {
    id: any;
    constructor() {}
    protected getAttributes() {
        const objAttributes: Record<string, any> = {};
        Object.entries(this)
            .filter((entrie) => typeof entrie[1] !== 'function')
            .map((entrie) => {
                objAttributes[entrie[0]] = entrie[1];
            });

        return objAttributes;
    }

    protected getDbInfoByAttributes() {
        const objAttributes: Record<string, any> = {};
        Object.entries(this.getAttributes())
            .filter((entrie) => !Array.isArray(entrie[1]))
            .map((entrie) => {
                if (entrie[1] instanceof Entity) {
                    objAttributes[`${entrie[0]}Id`] = entrie[1]['id'];
                } else {
                    objAttributes[entrie[0]] = entrie[1];
                }
            });

        return objAttributes;
    }

    getDbInfo() {
        const objAttributes = this.getDbInfoByAttributes();

        return Mapper.camelToSnake(objAttributes);
    }

    protected mapEntryObj(obj: Record<string, any>) {
        return Mapper.snakeToCamel(Mapper.oneToMultLayer(obj));
    }
}
