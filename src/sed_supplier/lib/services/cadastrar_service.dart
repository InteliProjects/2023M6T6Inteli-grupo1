import 'dart:convert';
import 'package:http/http.dart' as http;


const String baseUrl = "http://34.224.239.245/supplierUsers";

createUser(String email, String senha, String name) async {
  var url = Uri.parse("$baseUrl/");
  var headers = {'Content-Type': 'application/json'};
  var body = jsonEncode({"email": email, "password": senha, "name": name});

  var response = await http.post(url, headers: headers, body: body);
  return response;
}