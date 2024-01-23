import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sed_supplier/services/login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

void main(List<String> args) {
  getCardHomeSupplier();
}

const String baseUrl = "http://34.224.239.245/supplierUsers";

Future<Map<String, Map<int, int>>> getCardHomeSupplier() async {
  try {

    var token = await getData("tokenSupplierUsers");
    var headers = {'Authorization': 'Bearer $token'};
    var response = await http.get(Uri.parse("$baseUrl/deliveries"), headers: headers);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      if (jsonData is Map<String, dynamic> && jsonData['data'] is List) {
        var data = jsonData['data'] as List;

        // Inicializar mapas para armazenar as somas
        var totalSums = <int, int>{};
        var completedSums = <int, int>{};

        for (var item in data) {
          int companyId = item['shipping_company_id'];
          int quantity = item['quantity'];

          // Soma total
          totalSums[companyId] = (totalSums[companyId] ?? 0) + quantity;

          // Soma para status 'COMPLETED'
          if (item['status_id'] == 'COMPLETED') {
            completedSums[companyId] = (completedSums[companyId] ?? 0) + quantity;
          }
        }

        return {
          'totalSums': totalSums,
          'completedSums': completedSums
        };
      } else {
        throw Exception("Invalid JSON format");
      }
    } else {
      throw Exception("Failed to load data. Status code: ${response.statusCode}");
    }
  } catch (e) {
    throw Exception("Failed to load data: $e");
  }
}

