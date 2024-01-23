import MysqlConnection from '../../connections/database/mysql.database.connection';
import { IFilter, IOrderCondition, IPagination } from '../../utils/queryBuilder/IqueryBuilder.util';
import DatabaseEntityRepository from './databaseEntity.repository';

export default class OrderRepository extends DatabaseEntityRepository {
    constructor(databaseConnection: MysqlConnection) {
        super('order', databaseConnection);
    }

    listWithSupplier(
        filters?: IFilter | undefined,
        orders?: IOrderCondition[] | undefined,
        pagination?: IPagination | undefined,
    ): Promise<any[]> {
        return this.databaseConnection.doSelect(`
            SELECT ${this.queryBuilder.escapeId(this.tableName)}.*,
                su.name as supplier_name,
                su.email as supplier_email
            FROM ${this.queryBuilder.escapeId(this.tableName)}
                INNER JOIN ${this.queryBuilder.escapeId('supplier_user')} su ON su.id = ${this.queryBuilder.escapeId(
            this.tableName,
        )}.supplier_id 
            ${filters ? `WHERE ${this.queryBuilder.normalizeFilters(filters)}` : ''}
            ${orders ? `ORDER BY ${this.queryBuilder.normalizeOrders(orders)}` : ''}
            ${pagination ? this.queryBuilder.normalizePagination(pagination) : ''}
        `);
    }

    getItemsCount(filters?: IFilter, orders?: IOrderCondition[], pagination?: IPagination) {
        return this.databaseConnection.doSelect<{ item_name: string; qtd: number }>(`
            SELECT item_name, COUNT(id) as qtd
            FROM ${this.queryBuilder.escapeId(this.tableName)}
                ${filters ? `WHERE ${this.queryBuilder.normalizeFilters(filters)}` : ''}
                ${orders ? `ORDER BY ${this.queryBuilder.normalizeOrders(orders)}` : ''}
            GROUP BY item_name
            ${pagination ? this.queryBuilder.normalizePagination(pagination) : ''}
        `);
    }
}
