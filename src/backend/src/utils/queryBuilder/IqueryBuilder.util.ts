export interface ICondition {
    table?: string;
    field: string;
    value: any;
    dontEscape?: boolean;
}

export interface IInCondition extends ICondition {
    value: any[];
}

export interface ILikeCondition extends ICondition {
    value: string | number;
}

export interface IOrderCondition {
    table?: string;
    field: string;
    order: 'ASC' | 'DESC';
}

export interface IPagination {
    pageSize: number;
    page: number;
}

export interface IConditionOperator {
    $AND?: IFilter[];
    $OR?: IFilter[];
    $LIKE?: ILikeCondition;
    $IN?: IInCondition;
}

export type IFilter = IConditionOperator | ICondition;
