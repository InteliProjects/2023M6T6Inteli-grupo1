import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sed_supplier/services/login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';


const String baseUrl = "http://34.224.239.245/supplierUsers";


Future<Map<int, String>> fetchShippingCompanies() async {
  var token = await getData("tokenSupplierUsers");
  var headers = {'Authorization': 'Bearer $token'};
  var response = await http.get(Uri.parse("$baseUrl/shippingCompanies"), headers: headers);
  var jsonData = jsonDecode(response.body);
  Map<int, String> shippingCompanies = {};

  if (jsonData['data'] is List) {
    for (var company in jsonData['data']) {
      shippingCompanies[company['id']] = company['name'];
    }
  }

  print(shippingCompanies);
  return shippingCompanies;
}

Future<List<dynamic>> getListCardHome() async {
  try {
    var token = await getData("tokenSupplierUsers");
    var headers = {'Authorization': 'Bearer $token'};
    var response = await http.get(Uri.parse("$baseUrl/orders"), headers: headers);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      if (jsonData is Map<String, dynamic> && jsonData['data'] is List) {
        List data = jsonData['data'];
        List<Map<String, dynamic>> groupedData = [];
        var shippingCompanies = await fetchShippingCompanies();

        for (var order in data) {
          Map<String, int> shippingCompanyQuantities = {};
          Map<String, int> shippingCompanyDeliveredQuantities = {};

          if (order['deliveries'] is List) {
            for (var delivery in order['deliveries']) {
              String shippingCompanyName = shippingCompanies[delivery['shippingCompanyId']] ?? delivery['shippingCompanyId'].toString();
              int quantity = delivery['quantity'] ?? 0;

              shippingCompanyQuantities.update(
                shippingCompanyName,
                (existingQuantity) => existingQuantity + quantity,
                ifAbsent: () => quantity
              );

              if (delivery['statusId'] == "COMPLETED") {
                shippingCompanyDeliveredQuantities.update(
                  shippingCompanyName,
                  (existingDeliveredQuantity) => existingDeliveredQuantity + quantity,
                  ifAbsent: () => quantity
                );
              }
            }
          }

          groupedData.add({
            'id': order['id'],
            'itemName': order['itemName'],
            'totalQuantities': shippingCompanyQuantities,
            'deliveredQuantities': shippingCompanyDeliveredQuantities
          });
        }
        return groupedData;
      } else {
        throw Exception("The JSON response does not contain an 'data' key with a list");
      }
    } else {
      throw Exception("Failed to load posts. Status code: ${response.statusCode}");
    }
  } catch (e) {
    throw Exception("Failed to load posts: $e");
  }
}



Future<List<dynamic>> getListBySchool() async {
  try {
     var token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTMsImlhdCI6MTcwMjYwOTM1MH0.3ZEmWlaje0d-pthIrZeo-7k-QfABHb6N0jBCk8XDgCM";
    // var token = await getData("tokenSupplierUsers");
    var headers = {'Authorization': 'Bearer $token'};
    var response = await http.get(Uri.parse("$baseUrl/orders"), headers: headers);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      if (jsonData is Map<String, dynamic> && jsonData['data'] is List) {
        List data = jsonData['data'];

        List<Map<String, dynamic>> groupedData = [];

        for (var order in data) {
          Map<int, Map<String, dynamic>> schoolQuantities = {};

          if (order['deliveries'] is List) {
            for (var delivery in order['deliveries']) {
              int schoolId = delivery['schoolId'];
              int quantity = delivery['quantity'] ?? 0;
              String schoolName = delivery['school']['name'];

              schoolQuantities.update(
                schoolId,
                (existingSchoolData) {
                  existingSchoolData['totalQuantity'] += quantity;

                  if (delivery['statusId'] == "COMPLETED") {
                    existingSchoolData['deliveredQuantity'] += quantity;
                  }

                  return existingSchoolData;
                },
                ifAbsent: () => {
                  'schoolName': schoolName,
                  'totalQuantity': quantity,
                  'deliveredQuantity': delivery['statusId'] == "COMPLETED" ? quantity : 0
                }
              );
            }
          }

          groupedData.add({
            'orderId': order['id'],
            'itemName': order['itemName'], // Inclui o itemName
            'schools': schoolQuantities.values.toList()
          });
        }
        return groupedData;
      } else {
        throw Exception("The JSON response does not contain a 'data' key with a list");
      }
    } else {
      throw Exception("Failed to load orders. Status code: ${response.statusCode}");
    }
  } catch (e) {
    throw Exception("Failed to load orders: $e");
  }
}