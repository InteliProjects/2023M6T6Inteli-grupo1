import { matchedData, validationResult } from 'express-validator';
import ApiError from '../infra/ApiError/ApiError';
import Mapper from '../utils/mapper/mapper.util';
import { Request } from 'express';
import { ICondition, IFilter, IOrderCondition, IPagination } from '../utils/queryBuilder/IqueryBuilder.util';

export default class Controller {
    protected defaultPageSize: number;
    protected fieldsToIgnoreOnFilters: string[];
    protected fieldsToSearch: (string | ICondition)[];

    constructor(
        defaultPageSize: number = 30,
        fieldsToIgnoreOnFilters: string[] = [],
        fieldsToSearch: (string | ICondition)[] = ['name', 'id'],
    ) {
        this.defaultPageSize = defaultPageSize;
        this.fieldsToIgnoreOnFilters = fieldsToIgnoreOnFilters;
        this.fieldsToSearch = fieldsToSearch;
    }

    protected matchData(req: Request) {
        const result = matchedData(req);
        return result;
    }

    protected validationResult(req: Request) {
        const result = validationResult(req);

        if (!result.isEmpty()) {
            throw new ApiError(result.array(), 400, false);
        }
    }

    protected validateAndMatch(req: Request) {
        this.validationResult(req);
        return this.matchData(req);
    }

    protected getPaginationFromQueryParams(req: Request, defaultPageSize: number = this.defaultPageSize): IPagination {
        const pagination = {
            page: Number(req.query.paginationPage) || 1,
            pageSize: Number(req.query.paginationPageSize) || defaultPageSize,
        };

        return pagination;
    }

    protected getOrdersFromQueryParams(req: Request) {
        const orders: IOrderCondition[] = [];

        if (req.query.orderBy) {
            (String(req.query.orderBy) || '').split(',').forEach((queryOrder) => {
                const queryOrderSplitted = queryOrder.split('-');

                const baseOfParams = Mapper.camelToSnake(queryOrderSplitted[0]).split('_');

                orders.push({
                    table: baseOfParams[0] == 'omp' ? baseOfParams.slice(0, 2).join('_') : undefined,
                    field: baseOfParams[0] == 'omp' ? baseOfParams.slice(2).join('_') : baseOfParams.join('_'),
                    order: queryOrderSplitted[1].toUpperCase() == 'ASC' ? 'ASC' : 'DESC',
                });
            });
        }

        return orders.length ? orders : undefined;
    }

    protected getFiltersFromQueryParams(
        req: Request,
        options: { fieldsToSearch: (string | ICondition)[]; fieldsToIgnore: string[] },
    ) {
        const filters: IFilter = { $AND: [] };

        if (options) {
            if (req.query.search) {
                filters.$AND?.push({
                    $OR: options.fieldsToSearch.map((fieldToSearch) => {
                        return typeof fieldToSearch == 'object'
                            ? {
                                  $LIKE: {
                                      table: fieldToSearch.table,
                                      field: fieldToSearch.field,
                                      value: `%${req.query.search}%`,
                                  },
                              }
                            : { $LIKE: { field: fieldToSearch, value: `%${req.query.search}%` } };
                    }),
                });
            }
        }

        const fieldsToIgnore = options?.fieldsToIgnore || [];
        fieldsToIgnore.push(...['paginationPage', 'paginationPageSize', 'orderBy', 'search']);

        Object.entries(req.query || {})
            .filter((queryParamEntrie) => !fieldsToIgnore.includes(queryParamEntrie[0]))
            .forEach((queryParamEntrie) => {
                const baseOfParams = Mapper.camelToSnake(queryParamEntrie[0]).split('_');
                filters.$AND?.push({
                    table: baseOfParams[0] == 'omp' ? baseOfParams.slice(0, 2).join('_') : undefined,
                    field: baseOfParams[0] == 'omp' ? baseOfParams.slice(2).join('_') : baseOfParams.join('_'),
                    value: queryParamEntrie[1],
                });
            });

        return filters.$AND?.length ? filters : undefined;
    }

    protected getFiltersOrdersAndPagination(
        req: Request,
        fieldsToSearch = this.fieldsToSearch,
        fieldsToIgnore = this.fieldsToIgnoreOnFilters,
        defaultPageSize = this.defaultPageSize,
    ) {
        return {
            filters: this.getFiltersFromQueryParams(req, { fieldsToSearch, fieldsToIgnore }),
            orders: this.getOrdersFromQueryParams(req),
            pagination: this.getPaginationFromQueryParams(req, defaultPageSize),
        };
    }

    protected makeListJson(data: any, counts: Record<string, any>, pagination: IPagination) {
        return {
            ...(counts || {}),
            ...(pagination || {}),
            data,
        };
    }
}
