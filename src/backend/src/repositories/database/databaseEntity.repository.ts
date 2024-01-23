import MysqlConnection from '../../connections/database/mysql.database.connection';
import { IFilter, IOrderCondition, IPagination } from '../../utils/queryBuilder/IqueryBuilder.util';
import MysqlQueryBuilder from '../../utils/queryBuilder/queryBuilder.util';

export default class DatabaseEntityRepository {
    public tableName: string;
    protected databaseConnection: MysqlConnection;
    protected queryBuilder: MysqlQueryBuilder;
    protected identifierColumns: string[];

    constructor(tableName: string, databaseConnection: MysqlConnection, identifierColumns: string[] = ['id']) {
        this.tableName = tableName;
        this.databaseConnection = databaseConnection;
        this.queryBuilder = new MysqlQueryBuilder(this.tableName);
        this.identifierColumns = identifierColumns;
    }

    async findById(id: number | string) {
        return this.find(this.getIdentifierColumnsCondition(id));
    }

    async updateById(id: number | string, data: Record<string, any>) {
        return this.update(this.getIdentifierColumnsCondition(id), data);
    }

    async deleteById(id: number | string) {
        return this.delete(this.getIdentifierColumnsCondition(id));
    }

    async list(filters?: IFilter, orders?: IOrderCondition[], pagination?: IPagination) {
        return this.databaseConnection.doSelect(`
            SELECT *
            FROM ${this.queryBuilder.escapeId(this.tableName)}
            ${filters ? `WHERE ${this.queryBuilder.normalizeFilters(filters)}` : ''}
            ${orders ? `ORDER BY ${this.queryBuilder.normalizeOrders(orders)}` : ''}
            ${pagination ? this.queryBuilder.normalizePagination(pagination) : ''}
        `);
    }

    async listCount(filters?: IFilter) {
        const result = await this.databaseConnection.doSelectOne(`
            SELECT COUNT(${this.queryBuilder.escapeId(this.tableName)}.id) as qt
            FROM ${this.queryBuilder.escapeId(this.tableName)}
            ${filters ? `WHERE ${this.queryBuilder.normalizeFilters(filters)}` : ''}
        `);

        return result;
    }

    async find(filters: IFilter) {
        return this.databaseConnection.doSelectOne(`
            SELECT *
            FROM ${this.queryBuilder.escapeId(this.tableName)}
            WHERE ${this.queryBuilder.normalizeFilters(filters)}
            LIMIT 1
        `);
    }

    async create(data: Record<string, any>) {
        return this.databaseConnection.doCreate(`
            INSERT INTO ${this.queryBuilder.escapeId(this.tableName)}
            (${Object.keys(data)
                .map((value) => this.queryBuilder.escapeId(value))
                .join(', ')})
            VALUES
            (${Object.values(data)
                .map((value) => this.queryBuilder.escape(value))
                .join(', ')})
        `);
    }

    async update(filters: IFilter, data: Record<string, any>) {
        return this.databaseConnection.doCreate(`
            UPDATE ${this.queryBuilder.escapeId(this.tableName)}
            SET ${Object.entries(data)
                .map((entrie) => `${this.queryBuilder.escapeId(entrie[0])} = ${this.queryBuilder.escape(entrie[1])}`)
                .join(', ')}
            WHERE
                ${this.queryBuilder.normalizeFilters(filters)}
        `);
    }

    async delete(filters: IFilter) {
        return this.databaseConnection.doDelete(`
            DELETE FROM ${this.queryBuilder.escapeId(this.tableName)}
            WHERE ${this.queryBuilder.normalizeFilters(filters)}
        `);
    }

    protected getIdentifierColumnsCondition(value: any): IFilter {
        if (this.identifierColumns.length == 1) {
            return { field: this.identifierColumns[0], value: value };
        } else {
            return {
                $AND: this.identifierColumns.map((identifierColumn) => {
                    return { field: identifierColumn, value: value };
                }),
            };
        }
    }
}
