import 'dart:convert';
import 'package:giapha/core/api/auth_service.dart';
import 'package:giapha/core/api/response_api.dart';
import 'package:giapha/core/constants/endpoint_constrants.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static String baseUrl = EndPointConstrants.domain;

  static Future<APIResponse> fetchData(String endpoint,
      {Map<String, dynamic>? params}) async {
    // Xây dựng URL với các tham số nếu có
    final uri =
        Uri.parse('$baseUrl/$endpoint').replace(queryParameters: params);

    final response = await http.get(uri, headers: {
      'x-api-key': AuthService.apiKey,
      'x-client-id': AuthService.clientId,
      'Authorization': AuthService.accessToken
    });

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<dynamic> postData(
      String endpoint, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      body: json.encode(data),
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': AuthService.apiKey,
        'x-client-id': AuthService.clientId,
        'Authorization': AuthService.accessToken,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
