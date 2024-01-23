import SchoolUser from '../entities/schoolUser.entity';
import SchoolAuthAPIRepository from '../repositories/auth/schoolAuth.api.repository';
import SchoolUserRepository from '../repositories/database/schoolUser.repository';
import Service from './service';

export default class SchoolUserService extends Service<SchoolUser, SchoolUserRepository> {
    schoolAuthRepository: SchoolAuthAPIRepository;
    constructor(repository: SchoolUserRepository, schoolAuthRepository: SchoolAuthAPIRepository) {
        super(repository, SchoolUser);
        this.schoolAuthRepository = schoolAuthRepository;
    }

    login = async (email: string, password: string) => {
        return await this.schoolAuthRepository.login(email, password);
    };

    verifyToken = async (token: string) => {
        return await this.schoolAuthRepository.validateToken(token);
    };
}
