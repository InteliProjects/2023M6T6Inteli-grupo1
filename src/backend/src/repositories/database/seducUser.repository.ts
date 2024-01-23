import MysqlConnection from '../../connections/database/mysql.database.connection';
import DatabaseEntityRepository from './databaseEntity.repository';

export default class SeducUserRepository extends DatabaseEntityRepository {
    constructor(databaseConnection: MysqlConnection) {
        super('seduc_user', databaseConnection);
    }
}
