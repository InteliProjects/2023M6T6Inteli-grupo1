import SchoolBoard from '../entities/schoolBoard.entity';
import SchoolBoardRepository from '../repositories/database/schoolBoard.repository';
import Service from './service';

export default class SchoolBoardService extends Service<SchoolBoard, SchoolBoardRepository> {
    constructor(repository: SchoolBoardRepository) {
        super(repository, SchoolBoard);
    }
}
