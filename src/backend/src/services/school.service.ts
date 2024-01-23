import School from '../entities/school.entity';
import SchoolRepository from '../repositories/database/school.repository';
import Service from './service';

export default class SchoolService extends Service<School, SchoolRepository> {
    constructor(repository: SchoolRepository) {
        super(repository, School);
    }
}
