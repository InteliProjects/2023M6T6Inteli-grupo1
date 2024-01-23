import 'package:sed_supplier/services/api_service.dart';

class SedApiService extends ApiService {
  String token;
  SedApiService(this.token) : super('http://34.224.239.245/supplierUsers/');

  login(String email, String password) async {
    var response =
        await super.post('login', {"email": email, "password": password});
    token = response['token'];

    return response;
  }

  createUser(String email, String name, String password) async {
    return super.post('', {"email": email, "name": name, "password": password});
  }

  listOrders() {
    return super.get('orders', _createHeaderWithToken());
  }

  listSchoolBoards() {
    return super.get('schoolBoards', _createHeaderWithToken());
  }

  listDeliveries() {
    return super.get('deliveries', _createHeaderWithToken());
  }

  createDelivery(int orderId, int schoolId, int shippingCompanyId, int quantity,
      String initialForecast, String finalForecast) {
    return super.post(
        'deliveries',
        {
          "orderId": orderId,
          "schoolId": schoolId,
          "shippingCompanyId": shippingCompanyId,
          "quantity": quantity,
          "initialForecast": initialForecast,
          "finalForecast": finalForecast
        },
        _createHeaderWithToken());
  }

  _createHeaderWithToken() {
    return {"Authorization": "Bearer $token"};
  }
}
