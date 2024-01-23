import SupplierRecommendationApiConnection from "../../connections/apis/supplierRecommendation/supplierRecommendation.api.connection";

export default class SupplierRecommendationRepository {
    protected APIConnection: SupplierRecommendationApiConnection;
    constructor(connection: SupplierRecommendationApiConnection) {
        this.APIConnection = connection;
    }

    async supplierByCieList(cieList: number[]): Promise<string | null> {
        const response = await this.APIConnection.bestSupplierByCieList(cieList);
        const cnpj = response?.supplierCnpj;

        if(cnpj) {
            return cnpj.match(/\d/g)?.join("") as string
        }

        return cnpj;
    }
}
