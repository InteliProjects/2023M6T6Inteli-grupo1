import MysqlConnection from '../../connections/database/mysql.database.connection';
import DatabaseEntityRepository from './databaseEntity.repository';

export default class SupplierUserRepository extends DatabaseEntityRepository {
    constructor(databaseConnection: MysqlConnection) {
        super('supplier_user', databaseConnection);
    }
}