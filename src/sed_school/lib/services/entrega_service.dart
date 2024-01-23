import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sed_school/services/login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

const String baseUrl = "http://34.224.239.245/schools";

Future<void> pedidoRecebido(double nota, String id) async {
  try {
    var token = await getData("token");
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('$baseUrl/deliveries/$id/rating');
    var body = jsonEncode({
      "rating": nota,
    });

    var response = await http.patch(url, headers: headers, body: body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Post NOTA com sucesso!");
    } else {
      throw Exception(
          "Failed to send post. Status code: ${response.statusCode}");
    }
  } catch (e) {
    throw Exception("Failed to send post: $e");
  }
}

Future<void> pedidoRecebidoStatus(double nota, String id) async {
  try {
    var token = await getData("token");
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('$baseUrl/deliveries/$id/status');
    var body = jsonEncode({
      "status": 'COMPLETED',
    });

    var response = await http.patch(url, headers: headers, body: body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      pedidoRecebido(nota, id);
      print("Post ENTREGUE com sucesso!");
    } else {
      throw Exception(
          "Failed to send post. Status code: ${response.statusCode}");
    }
  } catch (e) {
    throw Exception("Failed to send post: $e");
  }
}
