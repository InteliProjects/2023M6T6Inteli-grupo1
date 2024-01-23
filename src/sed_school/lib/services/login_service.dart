import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const String baseUrl = "http://34.224.239.245/schools";

getLogin(String email, String senha) async {
  var url = Uri.parse("$baseUrl/login");
  var headers = {'Content-Type': 'application/json'};
  var body = jsonEncode({"email": email, "password": senha});

  var response = await http.post(url, headers: headers, body: body);
  return response;
}

void saveData(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}

Future<String?> getData(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? value = prefs.getString(key);
  return value;
}
