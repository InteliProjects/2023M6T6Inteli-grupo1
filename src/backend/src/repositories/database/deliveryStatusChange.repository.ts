import MysqlConnection from '../../connections/database/mysql.database.connection';
import { IFilter, IOrderCondition, IPagination } from '../../utils/queryBuilder/IqueryBuilder.util';
import DatabaseEntityRepository from './databaseEntity.repository';

export default class DeliveryStatusChangeRepository extends DatabaseEntityRepository {
    constructor(databaseConnection: MysqlConnection) {
        super('delivery_status_change', databaseConnection);
    }

    listCount = async (filters?: IFilter | undefined): Promise<any> => {
        const result = await this.databaseConnection.doSelectOne(`
            SELECT COUNT(${this.queryBuilder.escapeId(this.tableName)}.delivery_id) as qt
            FROM ${this.queryBuilder.escapeId(this.tableName)}
            ${filters ? `WHERE ${this.queryBuilder.normalizeFilters(filters)}` : ''}
        `);

        return result;
    };

    listBySchool(
        id: number,
        orders?: IOrderCondition[] | undefined,
        pagination?: IPagination | undefined,
    ): Promise<any[]> {
        return this.databaseConnection.doSelect(`
            SELECT ${this.queryBuilder.escapeId(this.tableName)}.* 
            FROM ${this.queryBuilder.escapeId(this.tableName)}
                INNER JOIN ${this.queryBuilder.escapeId('delivery')} ON ${this.queryBuilder.escapeId(
            'delivery',
        )}.id = ${this.queryBuilder.escapeId(this.tableName)}.delivery_id 
            WHERE ${this.queryBuilder.escapeId('delivery')}.school_id = ${this.queryBuilder.escape(id)}
            ${orders ? `ORDER BY ${this.queryBuilder.normalizeOrders(orders)}` : ''}
            ${pagination ? this.queryBuilder.normalizePagination(pagination) : ''}
        `);
    }

    listCountBySchool(id: number): Promise<any[]> {
        return this.databaseConnection.doSelect(`
            SELECT COUNT(DISTINCT ${this.queryBuilder.escapeId(this.tableName)}.delivery_id) AS qt
            FROM ${this.queryBuilder.escapeId(this.tableName)}
                INNER JOIN ${this.queryBuilder.escapeId('delivery')} ON ${this.queryBuilder.escapeId(
            'delivery',
        )}.id = ${this.queryBuilder.escapeId(this.tableName)}.delivery_id 
            WHERE ${this.queryBuilder.escapeId('delivery')}.school_id = ${this.queryBuilder.escape(id)}
        `);
    }

    listByShippingCompany(
        id: number,
        orders?: IOrderCondition[] | undefined,
        pagination?: IPagination | undefined,
    ): Promise<any[]> {
        return this.databaseConnection.doSelect(`
            SELECT ${this.queryBuilder.escapeId(this.tableName)}.* 
            FROM ${this.queryBuilder.escapeId(this.tableName)}
                INNER JOIN ${this.queryBuilder.escapeId('delivery')} ON ${this.queryBuilder.escapeId(
            'delivery',
        )}.id = ${this.queryBuilder.escapeId(this.tableName)}.delivery_id 
            WHERE ${this.queryBuilder.escapeId('delivery')}.shipping_company_id = ${this.queryBuilder.escape(id)}
            ${orders ? `ORDER BY ${this.queryBuilder.normalizeOrders(orders)}` : ''}
            ${pagination ? this.queryBuilder.normalizePagination(pagination) : ''}
        `);
    }

    listCountByShippingCompany(id: number): Promise<any[]> {
        return this.databaseConnection.doSelect(`
            SELECT COUNT(DISTINCT ${this.queryBuilder.escapeId(this.tableName)}.delivery_id) AS qt
            FROM ${this.queryBuilder.escapeId(this.tableName)}
                INNER JOIN ${this.queryBuilder.escapeId('delivery')} ON ${this.queryBuilder.escapeId(
            'delivery',
        )}.id = ${this.queryBuilder.escapeId(this.tableName)}.delivery_id 
            WHERE ${this.queryBuilder.escapeId('delivery')}.shipping_company_id = ${this.queryBuilder.escape(id)}
        `);
    }

    listBySupplier(
        id: number,
        orders?: IOrderCondition[] | undefined,
        pagination?: IPagination | undefined,
    ): Promise<any[]> {
        return this.databaseConnection.doSelect(`
            SELECT ${this.queryBuilder.escapeId(this.tableName)}.* 
            FROM ${this.queryBuilder.escapeId(this.tableName)}
                INNER JOIN ${this.queryBuilder.escapeId('delivery')} ON ${this.queryBuilder.escapeId(
            'delivery',
        )}.id = ${this.queryBuilder.escapeId(this.tableName)}.delivery_id 
                INNER JOIN ${this.queryBuilder.escapeId('order')} ON ${this.queryBuilder.escapeId(
            'order',
        )}.id = ${this.queryBuilder.escapeId('delivery')}.order_id 
            WHERE ${this.queryBuilder.escapeId('order')}.supplier_id = ${this.queryBuilder.escape(id)}
            ${orders ? `ORDER BY ${this.queryBuilder.normalizeOrders(orders)}` : ''}
            ${pagination ? this.queryBuilder.normalizePagination(pagination) : ''}
        `);
    }

    listCountBySupplier(id: number): Promise<any[]> {
        return this.databaseConnection.doSelect(`
            SELECT COUNT(DISTINCT ${this.queryBuilder.escapeId(this.tableName)}.delivery_id) AS qt
            FROM ${this.queryBuilder.escapeId(this.tableName)}
                INNER JOIN ${this.queryBuilder.escapeId('delivery')} ON ${this.queryBuilder.escapeId(
            'delivery',
        )}.id = ${this.queryBuilder.escapeId(this.tableName)}.delivery_id 
                INNER JOIN ${this.queryBuilder.escapeId('order')} ON ${this.queryBuilder.escapeId(
            'order',
        )}.id = ${this.queryBuilder.escapeId('delivery')}.order_id 
            WHERE ${this.queryBuilder.escapeId('order')}.supplier_id = ${this.queryBuilder.escape(id)}
        `);
    }
}
