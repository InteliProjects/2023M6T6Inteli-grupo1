import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  String baseUrl;

  ApiService(this.baseUrl);

  Future<Map<String, dynamic>> get(String url,
      [Map<String, dynamic>? headers]) async {
    var parsedUrl = Uri.parse("$baseUrl$url");

    var newHeaders = _formatHeaders(headers);

    var response = await http.get(parsedUrl, headers: newHeaders);

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> post(String url,
      [Map<String, dynamic>? body, Map<String, dynamic>? headers]) async {
    var parsedUrl = Uri.parse("$baseUrl$url");

    var newHeaders = _formatHeaders(headers);
    var newBody = _formatBody(body);

    var response =
        await http.post(parsedUrl, body: newBody, headers: newHeaders);

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> patch(String url,
      [Map<String, dynamic>? body, Map<String, dynamic>? headers]) async {
    var parsedUrl = Uri.parse("$baseUrl$url");

    var newHeaders = _formatHeaders(headers);
    var newBody = _formatBody(body);

    var response =
        await http.patch(parsedUrl, body: newBody, headers: newHeaders);

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> delete(String url,
      [Map<String, dynamic>? body, Map<String, dynamic>? headers]) async {
    var parsedUrl = Uri.parse("$baseUrl$url");

    var newHeaders = _formatHeaders(headers);
    var newBody = _formatBody(body);

    var response =
        await http.delete(parsedUrl, body: newBody, headers: newHeaders);

    return jsonDecode(response.body);
  }

  _formatHeaders([Map<String, dynamic>? headers]) {
    var newHeaders = headers ?? {};
    if (newHeaders['Content-Type'] == null) {
      newHeaders['Content-Type'] = 'application/json';
    }
    return newHeaders;
  }

  _formatBody([Map<String, dynamic>? body]) {
    if (body == null) {
      return body;
    } else {
      return jsonEncode(body);
    }
  }
}
