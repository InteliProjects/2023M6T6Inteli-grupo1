import SchoolAuthAPIConnection from '../../connections/apis/auth/school.auth.api';
import AuthAPIRepository from './auth.api.repository';

export default class SchoolAuthAPIRepository extends AuthAPIRepository<SchoolAuthAPIConnection> {
    constructor(schoolAuthAPIConnection: SchoolAuthAPIConnection) {
        super(schoolAuthAPIConnection);
    }
}
