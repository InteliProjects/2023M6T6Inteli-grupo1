import SupplierUser from '../entities/supplierUser.entity';
import ApiError from '../infra/ApiError/ApiError';
import SchoolRepository from '../repositories/database/school.repository';
import SupplierUserRepository from '../repositories/database/supplierUser.repository';
import SupplierRecommendationRepository from '../repositories/supplierRecommendation/supplierRecommendation.repository';
import Encoding from '../utils/encoding/encoding.util';
import JWT from '../utils/jwt/jwt.util';
import Service from './service';

export default class SupplierUserService extends Service<SupplierUser, SupplierUserRepository> {
    jwt: JWT;
    schoolRepository: SchoolRepository;
    supplierRecommendationRepository: SupplierRecommendationRepository;

    constructor(repository: SupplierUserRepository, schoolRepository: SchoolRepository, supplierRecommendationRepository: SupplierRecommendationRepository, jwt: JWT) {
        super(repository, SupplierUser);
        this.jwt = jwt;
        this.schoolRepository = schoolRepository;
        this.supplierRecommendationRepository = supplierRecommendationRepository;
    }

    async create(data: Record<string, any>, withoutId: boolean = true) {
        data.password = Encoding.password(data.password);
        return super.create(data, withoutId);
    }

    login = async (email: string, password: string) => {
        try {
            const user = await this.find({
                $AND: [
                    { field: 'email', value: email },
                    { field: 'password', value: Encoding.password(password) },
                ],
            });

            return this.jwt.encode(user.id as number);
        } catch (error) {
            if (error instanceof ApiError && error.code == 404) {
                throw new ApiError('Invalid Credentials', 400, false);
            } else {
                throw error;
            }
        }
    };

    verifyToken = (token: string): { id: number } => {
        try {
            return this.jwt.verifyAndDecode(token);
        } catch (error) {
            throw new ApiError('Invalid Token', 400, false);
        }
    };

    predictPerSchoolBoard = async (schoolBoardId: number) => {
        const schools = await this.schoolRepository.list({field: 'board_id', value: schoolBoardId});

        const cies = schools.map(school => school.cie);

        if(!cies.length) {
            return null;
        }
        
        const cnpj = await this.supplierRecommendationRepository.supplierByCieList(cies);

        return this.repository.find({field: 'cnpj', value: cnpj});
    }
}
