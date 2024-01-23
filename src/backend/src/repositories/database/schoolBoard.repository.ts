import MysqlConnection from '../../connections/database/mysql.database.connection';
import DatabaseEntityRepository from './databaseEntity.repository';

export default class SchoolBoardRepository extends DatabaseEntityRepository {
    constructor(databaseConnection: MysqlConnection) {
        super('school_board', databaseConnection);
    }
}
