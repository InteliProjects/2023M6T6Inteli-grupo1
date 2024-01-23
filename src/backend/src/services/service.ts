import Entity from '../entities/entity';
import ApiError from '../infra/ApiError/ApiError';
import DatabaseEntityRepository from '../repositories/database/databaseEntity.repository';
import Mapper from '../utils/mapper/mapper.util';
import { IFilter, IOrderCondition, IPagination } from '../utils/queryBuilder/IqueryBuilder.util';

export default abstract class Service<
    entityService extends Entity,
    repositoryService extends DatabaseEntityRepository,
> {
    protected repository: repositoryService;
    protected entityConstructor: new (data: Record<string, any>) => entityService;

    constructor(repository: repositoryService, entityConstructor: new (data: Record<string, any>) => entityService) {
        this.repository = repository;
        this.entityConstructor = entityConstructor;
    }

    async createAndFind(data: Record<string, any>, withoutId: boolean = true) {
        const createdId = await this.create(data, withoutId);
        return this.findById(createdId);
    }

    async updateByIdAndFind(id: number | string, data: Record<string, any>) {
        await this.updateById(id, data);
        return this.findById(id);
    }

    async findById(id: number | string) {
        return this.find({ field: 'id', value: id });
    }

    async updateById(id: number | string, data: Record<string, any>) {
        return this.update({ field: 'id', value: id }, data);
    }

    async deleteById(id: number | string) {
        return this.delete({ field: 'id', value: id });
    }

    async list(filters?: IFilter, orders?: IOrderCondition[], pagination?: IPagination) {
        return this.getEntityFromData(await this.repository.list(filters, orders, pagination)) as entityService[];
    }

    async listCount(filters?: IFilter) {
        return await this.repository.listCount(filters);
    }

    async find(filters: IFilter) {
        const entityDatabase = await this.repository.find(filters);

        if (!entityDatabase) {
            throw new ApiError(`${this.repository.tableName} Not found`, 404, false);
        }

        return this.getEntityFromData(entityDatabase) as entityService;
    }

    async create(data: Record<string, any>, withoutId: boolean = true) {
        const databaseInfo = this.entityToDatabase(data);
        if (withoutId && typeof databaseInfo.id != 'undefined') {
            delete databaseInfo.id;
        }

        return this.repository.create(databaseInfo);
    }

    async update(filters: IFilter, data: Record<string, any>, withoutId: boolean = true) {
        if (withoutId && typeof data.id != 'undefined') {
            delete data.id;
        }

        data = Mapper.camelToSnake(data);

        return this.repository.update(filters, data);
    }

    async delete(filters: IFilter) {
        return this.repository.delete(filters);
    }

    protected mapDataToMultCamel(data: any) {
        return Mapper.snakeToCamel(Mapper.oneToMultLayer(data));
    }

    protected getEntityFromData(data: Record<string, any> | Record<string, any>[]) {
        if (Array.isArray(data)) {
            return data.map((info) => new this.entityConstructor(info));
        } else {
            return new this.entityConstructor(data);
        }
    }

    protected entityToDatabase(entity: entityService | Record<string, any>): Record<string, any> {
        if (entity instanceof this.entityConstructor) {
            return entity.getDbInfo();
        } else {
            return new this.entityConstructor(entity).getDbInfo();
        }
    }
}
