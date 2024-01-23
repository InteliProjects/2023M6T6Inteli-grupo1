import mysql from 'mysql';

import {
    ICondition,
    IConditionOperator,
    IFilter,
    IInCondition,
    ILikeCondition,
    IOrderCondition,
    IPagination,
} from './IqueryBuilder.util';

export default class MysqlQueryBuilder {
    private defaultTable?: string;

    constructor(defaultTable?: string) {
        this.defaultTable = defaultTable;
    }

    escape(value: any) {
        return mysql.escape(value);
    }

    escapeId(value: any) {
        return mysql.escapeId(value);
    }

    normalizeFilters(condition: IFilter): string {
        if (Object.keys(condition).find((key) => key == 'field')) {
            return this._normalizeCondition(condition as ICondition);
        } else {
            condition = condition as IConditionOperator;

            if (condition.$AND) {
                return this._normalizeAndCondition(condition.$AND);
            } else if (condition.$OR) {
                return this._normalizeOrCondition(condition.$OR);
            } else if (condition.$IN) {
                return this._normalizeInCondition(condition.$IN);
            } else if (condition.$LIKE) {
                return this._normalizeLikeCondition(condition.$LIKE);
            } else {
                return '';
            }
        }
    }

    normalizeOrders(orders: IOrderCondition[]) {
        return orders.map((order) => this._normalizeOrder(order)).join(', ');
    }

    normalizePagination(pagination: IPagination = { pageSize: 30, page: 1 }) {
        return `LIMIT ${pagination.pageSize} OFFSET ${(pagination.page - 1) * pagination.pageSize}`;
    }

    _normalizeOrder(order: IOrderCondition) {
        const tableName = order.table || this.defaultTable;
        return `${tableName ? `${this.escapeId(tableName)}.` : ''}${this.escapeId(order.field)} ${order.order}`;
    }

    _normalizeAndCondition(conditions: IFilter[]) {
        return conditions.length
            ? `(${conditions.map((condition) => this.normalizeFilters(condition)).join(' AND ')})`
            : '';
    }

    _normalizeOrCondition(conditions: IFilter[]) {
        return conditions.length
            ? `(${conditions.map((condition) => this.normalizeFilters(condition)).join(' OR ')})`
            : '';
    }

    _normalizeLikeCondition(condition: ILikeCondition) {
        const tableName = condition.table || this.defaultTable;
        return `${tableName ? `${this.escapeId(tableName)}.` : ''}${this.escapeId(condition.field)} LIKE ${
            condition.dontEscape ? condition.value : this.escape(condition.value)
        }`;
    }

    _normalizeInCondition(condition: IInCondition) {
        const tableName = condition.table || this.defaultTable;
        return `${tableName ? `${this.escapeId(tableName)}.` : ''}${this.escapeId(
            condition.field,
        )} IN (${condition.value.map((val) => (condition.dontEscape ? val : this.escape(val))).join(', ')})`;
    }

    _normalizeCondition(condition: ICondition) {
        const tableName = condition.table || this.defaultTable;
        return `${tableName ? `${this.escapeId(tableName)}.` : ''}${this.escapeId(condition.field)} = ${
            condition.dontEscape ? condition.value : this.escape(condition.value)
        }`;
    }
}
