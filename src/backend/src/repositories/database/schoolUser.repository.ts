import MysqlConnection from '../../connections/database/mysql.database.connection';
import DatabaseEntityRepository from './databaseEntity.repository';

export default class SchoolUserRepository extends DatabaseEntityRepository {
    constructor(databaseConnection: MysqlConnection) {
        super('school_user', databaseConnection);
    }
}
