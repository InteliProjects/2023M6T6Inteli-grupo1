import MysqlQueryBuilder from './queryBuilder.util';

describe('[MysqlQueryBuilder]', () => {
    describe('Without defaultTableName', () => {
        const queryBuilder = new MysqlQueryBuilder();

        describe('[normalizeFilters]', () => {
            it('has to create a simple verify', () => {
                expect(queryBuilder.normalizeFilters({ table: 'user', field: 'id', value: 1 })).toEqual(
                    '`user`.`id` = 1',
                );

                expect(queryBuilder.normalizeFilters({ field: 'id', value: 1 })).toEqual('`id` = 1');
            });

            it('has to create a complex verify', () => {
                expect(
                    queryBuilder.normalizeFilters({
                        $OR: [
                            { field: 'id', value: 1 },
                            { table: 'user', field: 'name', value: 'rafa' },
                            {
                                $AND: [
                                    { $IN: { table: 'table', field: 'field', value: ['haha', 1, null] } },
                                    { $IN: { field: 'field', value: ['haha', 1, null] } },
                                    { table: 'table', field: 'opa', value: 'valor' },
                                    { $LIKE: { table: 'tabelaLike', field: 'campoLike', value: '%text%' } },
                                    { $LIKE: { field: 'campoLike2', value: '%text%' } },
                                ],
                            },
                        ],
                    }),
                ).toEqual(
                    "(`id` = 1 OR `user`.`name` = 'rafa' OR (`table`.`field` IN ('haha', 1, NULL) AND `field` IN ('haha', 1, NULL) AND `table`.`opa` = 'valor' AND `tabelaLike`.`campoLike` LIKE '%text%' AND `campoLike2` LIKE '%text%'))",
                );
            });

            it('has to receive a empty object and return a empty string', () => {
                expect(queryBuilder.normalizeFilters({})).toEqual('');
            });
        });

        describe('[normalizeOrders]', () => {
            it('has to create a one order', () => {
                expect(queryBuilder.normalizeOrders([{ field: 'id', order: 'DESC' }])).toEqual('`id` DESC');
                expect(queryBuilder.normalizeOrders([{ field: 'id', order: 'ASC' }])).toEqual('`id` ASC');

                expect(queryBuilder.normalizeOrders([{ table: 'user', field: 'id', order: 'DESC' }])).toEqual(
                    '`user`.`id` DESC',
                );
                expect(queryBuilder.normalizeOrders([{ table: 'user', field: 'id', order: 'ASC' }])).toEqual(
                    '`user`.`id` ASC',
                );
            });

            it('has to receive a empty object and return a empty string', () => {
                expect(queryBuilder.normalizeOrders([])).toEqual('');
            });
        });

        describe('[normalizePagination]', () => {
            it('has to paginate', () => {
                expect(queryBuilder.normalizePagination({ page: 1, pageSize: 30 })).toEqual('LIMIT 30 OFFSET 0');
                expect(queryBuilder.normalizePagination({ page: 2, pageSize: 30 })).toEqual('LIMIT 30 OFFSET 30');
                expect(queryBuilder.normalizePagination({ page: -2, pageSize: 30 })).toEqual('LIMIT 30 OFFSET -90');
            });
        });
    });

    describe('With defaultTableName', () => {
        const queryBuilder = new MysqlQueryBuilder('myDefaultTable');

        describe('[normalizeFilters]', () => {
            it('has to create a simple verify', () => {
                expect(queryBuilder.normalizeFilters({ table: 'user', field: 'id', value: 1 })).toEqual(
                    '`user`.`id` = 1',
                );

                expect(queryBuilder.normalizeFilters({ field: 'id', value: 1 })).toEqual('`myDefaultTable`.`id` = 1');
            });

            it('has to create a complex verify', () => {
                expect(
                    queryBuilder.normalizeFilters({
                        $OR: [
                            { field: 'id', value: 1 },
                            { table: 'user', field: 'name', value: 'rafa' },
                            {
                                $AND: [
                                    { $IN: { table: 'table', field: 'field', value: ['haha', 1, null] } },
                                    { $IN: { field: 'field', value: ['haha', 1, null] } },
                                    { table: 'table', field: 'opa', value: 'valor' },
                                    { $LIKE: { table: 'tabelaLike', field: 'campoLike', value: '%text%' } },
                                    { $LIKE: { field: 'campoLike2', value: '%text%' } },
                                ],
                            },
                        ],
                    }),
                ).toEqual(
                    "(`myDefaultTable`.`id` = 1 OR `user`.`name` = 'rafa' OR (`table`.`field` IN ('haha', 1, NULL) AND `myDefaultTable`.`field` IN ('haha', 1, NULL) AND `table`.`opa` = 'valor' AND `tabelaLike`.`campoLike` LIKE '%text%' AND `myDefaultTable`.`campoLike2` LIKE '%text%'))",
                );
            });

            it('has to receive a empty object and return a empty string', () => {
                expect(queryBuilder.normalizeFilters({})).toEqual('');
            });
        });

        describe('[normalizeOrders]', () => {
            it('has to create a one order', () => {
                expect(queryBuilder.normalizeOrders([{ field: 'id', order: 'DESC' }])).toEqual(
                    '`myDefaultTable`.`id` DESC',
                );
                expect(queryBuilder.normalizeOrders([{ field: 'id', order: 'ASC' }])).toEqual(
                    '`myDefaultTable`.`id` ASC',
                );

                expect(queryBuilder.normalizeOrders([{ table: 'user', field: 'id', order: 'DESC' }])).toEqual(
                    '`user`.`id` DESC',
                );
                expect(queryBuilder.normalizeOrders([{ table: 'user', field: 'id', order: 'ASC' }])).toEqual(
                    '`user`.`id` ASC',
                );
            });

            it('has to receive a empty object and return a empty string', () => {
                expect(queryBuilder.normalizeOrders([])).toEqual('');
            });
        });

        describe('[normalizePagination]', () => {
            it('has to paginate', () => {
                expect(queryBuilder.normalizePagination({ page: 1, pageSize: 30 })).toEqual('LIMIT 30 OFFSET 0');
                expect(queryBuilder.normalizePagination({ page: 2, pageSize: 30 })).toEqual('LIMIT 30 OFFSET 30');
                expect(queryBuilder.normalizePagination({ page: -2, pageSize: 30 })).toEqual('LIMIT 30 OFFSET -90');
            });
        });
    });
});
