import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<List<Map<String, dynamic>>> fetchOrders() async {
    Future<String?> token = getTokenLocalStorage();
    final response = await http.get(
      Uri.parse('$baseUrl/seducUsers/orders'),
      headers: {'Authorization': 'Bearer ${await token}'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body)['data'];
      return jsonData.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Falha para carregar as ordens: ${response.body}}');
    }
  }

  Future<List<Map<String, dynamic>>> fetchDeliveries() async {
    Future<String?> token = getTokenLocalStorage();
    final response = await http.get(
      Uri.parse('$baseUrl/seducUsers/deliveries'),
      headers: {'Authorization': 'Bearer ${await token}'},
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body)['data'];
      return jsonData.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Falha para carregar as entregas: ${response.body}');
    }
  }

  Future<List<Map<String, dynamic>>> fetchItems() async {
    Future<String?> token = getTokenLocalStorage();
    final response = await http.get(
        Uri.parse('$baseUrl/seducUsers/orders/items'),
        headers: {'Authorization': 'Bearer ${await token}'});

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body)['data'];
      return jsonData.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Falha para carregar os itens: ${response.body}');
    }
  }

  Future<List<Map<String, dynamic>>> fetchSchoolsBords() async {
    Future<String?> token = getTokenLocalStorage();
    final response = await http.get(
        Uri.parse('$baseUrl/seducUsers/schoolBoards'),
        headers: {'Authorization': 'Bearer ${await token}'});

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body)['data'];

      return jsonData.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Falha para carregar as diretorias: ${response.body}');
    }
  }

  Future<List<Map<String, dynamic>>> fetchSuppliers() async {
    Future<String?> token = getTokenLocalStorage();
    final response = await http.get(Uri.parse('$baseUrl/seducUsers/suppliers'),
        headers: {'Authorization': 'Bearer ${await token}'});

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body)['data'];
      return jsonData.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Falha para carregar as diretorias: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> createOrder(Map<String, dynamic> data) async {
    Future<String?> token = getTokenLocalStorage();
    final response = await http.post(
      Uri.parse('$baseUrl/seducUsers/orders'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await token}'
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      return jsonData;
    } else {
      throw Exception('Falha para criar a ordem: ${response.body}');
    }
  }

  Future<http.Response> getToken(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/seducUsers/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({"email": email, "password": password}),
    );

    return response;
  }

  static Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  // Obter o token do armazenamento local
  static Future<String?> getTokenLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
}
