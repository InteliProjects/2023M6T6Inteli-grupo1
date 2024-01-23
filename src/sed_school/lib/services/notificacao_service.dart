import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sed_school/services/login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';







const String baseUrl = "http://34.224.239.245/schools";

Future<List<dynamic>> getCardNotificacao() async {
  try {
    // var token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJsb2dpbi50ZXN0ZS5lc2NvbGEudG9rZW5AZ21haWwuY29tIiwicm9sZXMiOlsic2Nob29sIl0sImlhdCI6MTcwMjQ4OTg1MX0.ClIiuMsrDGNNMtldD1sDYg3_tYhHDCvQTJEjEqlCO_U";
    var token = await getData("token");
    var headers = {'Authorization': 'Bearer $token'};
    var response =
        await http.get(Uri.parse("$baseUrl/deliveries/statusChanges"), headers: headers);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      // Verifica se jsonData contém a chave 'data' e se ela é uma lista.
      if (jsonData is Map<String, dynamic> && jsonData['data'] is List) {
        // Retorna a lista encontrada na chave 'data'.
        return jsonData['data'];
      } else {
        // Se a chave 'data' não for uma lista, lança uma exceção.
        throw Exception(
            "The JSON response does not contain an 'data' key with a list");
      }
    } else {
      // Se o status code não for 200, lança uma exceção.
      throw Exception(
          "Failed to load posts. Status code: ${response.statusCode}");
    }
  } catch (e) {
    // Captura exceções que possam ocorrer durante a chamada HTTP ou processamento do JSON.
    throw Exception("Failed to load posts: $e");
  }
}
