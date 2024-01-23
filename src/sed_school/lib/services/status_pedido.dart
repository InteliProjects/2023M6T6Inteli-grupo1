import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sed_school/services/login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

const String baseUrl = "http://34.224.239.245/schools";

Future<List<dynamic>> getStatusPedido(String id) async {
  try {
    var token = await getData("token");
    var headers = {'Authorization': 'Bearer $token'};
    var response =
        await http.get(Uri.parse("$baseUrl/deliveries/$id"), headers: headers);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      // Verifica se jsonData contém a chave 'data' e se ela é uma lista.
      if (jsonData is Map<String, dynamic> &&
          jsonData['statusChanges'] is List) {
        // Retorna a lista encontrada na chave 'data'.
        return jsonData['statusChanges'];
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
