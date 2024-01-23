import MysqlConnection from '../../connections/database/mysql.database.connection';
import { IFilter, IOrderCondition, IPagination } from '../../utils/queryBuilder/IqueryBuilder.util';
import DatabaseEntityRepository from './databaseEntity.repository';

export default class DeliveryRepository extends DatabaseEntityRepository {
    constructor(databaseConnection: MysqlConnection) {
        super('delivery', databaseConnection);
    }

    listBySupplier(id: number, conditions?: IFilter) {
        return this.databaseConnection.doSelect(`
            SELECT ${this.queryBuilder.escapeId(this.tableName)}.*
            FROM ${this.queryBuilder.escapeId(this.tableName)}
                INNER JOIN ${this.queryBuilder.escapeId('order')} ON ${this.queryBuilder.escapeId(
            'order',
        )}.id = ${this.queryBuilder.escapeId(this.tableName)}.order_id
                INNER JOIN school ON school.id = delivery.school_id
                INNER JOIN school_board ON school_board.id = school.board_id
                INNER JOIN shipping_company ON shipping_company.id = delivery.shipping_company_id
            WHERE ${this.queryBuilder.escapeId('order')}.supplier_id = ${this.queryBuilder.escape(id)}
            ${conditions ? `AND ${this.queryBuilder.normalizeFilters(conditions)}` : ''}
        `);
    }

    listCountBySupplier(id: number, conditions?: IFilter) {
        return this.databaseConnection.doSelect(`
            SELECT COUNT(DISTINCT ${this.queryBuilder.escapeId(this.tableName)}.id) as qtd
            FROM ${this.queryBuilder.escapeId(this.tableName)}
                INNER JOIN ${this.queryBuilder.escapeId('order')} ON ${this.queryBuilder.escapeId(
            'order',
        )}.id = ${this.queryBuilder.escapeId(this.tableName)}.order_id
                INNER JOIN school ON school.id = delivery.school_id
                INNER JOIN school_board ON school_board.id = school.board_id
                INNER JOIN shipping_company ON shipping_company.id = delivery.shipping_company_id
            WHERE ${this.queryBuilder.escapeId('order')}.supplier_id = ${this.queryBuilder.escape(id)}
                ${conditions ? `AND ${this.queryBuilder.normalizeFilters(conditions)}` : ''}
        `);
    }
}
