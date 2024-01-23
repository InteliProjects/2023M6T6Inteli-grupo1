import SeducAuthAPIConnection from '../../connections/apis/auth/seduc.auth.api';
import AuthAPIRepository from './auth.api.repository';

export default class SeducAuthAPIRepository extends AuthAPIRepository<SeducAuthAPIConnection> {
    constructor(seducAuthAPIConnection: SeducAuthAPIConnection) {
        super(seducAuthAPIConnection);
    }
}
