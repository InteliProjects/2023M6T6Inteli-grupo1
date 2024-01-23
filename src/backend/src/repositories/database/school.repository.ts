import MysqlConnection from '../../connections/database/mysql.database.connection';
import { IFilter, IOrderCondition, IPagination } from '../../utils/queryBuilder/IqueryBuilder.util';
import DatabaseEntityRepository from './databaseEntity.repository';

export default class SchoolRepository extends DatabaseEntityRepository {
    constructor(databaseConnection: MysqlConnection) {
        super('school', databaseConnection);
    }

    listWithBoard(
        filters?: IFilter | undefined,
        orders?: IOrderCondition[] | undefined,
        pagination?: IPagination | undefined,
    ) {
        return this.databaseConnection.doSelect(`
            SELECT ${this.queryBuilder.escapeId(this.tableName)}.*,
                sb.name as board_name
            FROM ${this.queryBuilder.escapeId(this.tableName)}
                INNER JOIN ${this.queryBuilder.escapeId('school_board')} sb ON sb.id = ${this.queryBuilder.escapeId(
            this.tableName,
        )}.board_id     
            ${filters ? `WHERE ${this.queryBuilder.normalizeFilters(filters)}` : ''}
            ${orders ? `ORDER BY ${this.queryBuilder.normalizeOrders(orders)}` : ''}
            ${pagination ? this.queryBuilder.normalizePagination(pagination) : ''}
        `);
    }
}
