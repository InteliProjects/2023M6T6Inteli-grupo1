import SeducUser from '../entities/seducUser.entity';
import SeducAuthAPIRepository from '../repositories/auth/seducAuth.api.repository';
import SeducUserRepository from '../repositories/database/seducUser.repository';
import Encoding from '../utils/encoding/encoding.util';
import Service from './service';

export default class SeducUserService extends Service<SeducUser, SeducUserRepository> {
    private seducAuthRepository: SeducAuthAPIRepository;
    constructor(repository: SeducUserRepository, seducAuthRepository: SeducAuthAPIRepository) {
        super(repository, SeducUser);

        this.seducAuthRepository = seducAuthRepository;
    }

    login = async (email: string, password: string) => {
        return await this.seducAuthRepository.login(email, password);
    };

    verifyToken = async (token: string) => {
        return await this.seducAuthRepository.validateToken(token);
    };
}
