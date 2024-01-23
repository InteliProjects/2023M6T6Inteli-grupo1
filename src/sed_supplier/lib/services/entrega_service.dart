import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sed_supplier/services/login_service.dart';


const String baseUrl = "http://34.224.239.245/supplierUsers";

createDelivery(int orderID, int schoolsID, int shipingCompanyID, int quantity, String inicialForcast, String finalForcast ) async {
  var token = await getData("tokenSupplierUsers");
  var url = Uri.parse("$baseUrl/deliveries");
  var headers = {'Content-Type': 'application/json','Authorization': 'Bearer $token' };
  var body = jsonEncode({"orderId": orderID, "schoolId": schoolsID, "shippingCompanyId": shipingCompanyID, "quantity": quantity, "initialForecast": inicialForcast, "finalForecast": finalForcast});

  var response = await http.post(url, headers: headers, body: body);
  return response;
}