import APIConnection from '../api.connection';

export default class SupplierRecommendationApiConnection extends APIConnection {
    constructor(baseUrl: string) {
        super(baseUrl);
    }

    async bestSupplierByCieList(cieList: number[]): Promise<{ supplierCnpj: string }> {
        return this.post('/school_boards/suppliers/predict', {
            data: {
                cie_list: cieList
            },
        });
    }
}
