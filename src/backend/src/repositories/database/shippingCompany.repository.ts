import MysqlConnection from '../../connections/database/mysql.database.connection';
import DatabaseEntityRepository from './databaseEntity.repository';

export default class ShippingCompanyRepository extends DatabaseEntityRepository {
    constructor(databaseConnection: MysqlConnection) {
        super('shipping_company', databaseConnection);
    }
}
