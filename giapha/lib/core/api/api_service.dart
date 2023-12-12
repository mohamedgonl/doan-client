import 'dart:convert';
import 'package:giapha/core/api/auth_service.dart';
import 'package:giapha/core/api/response_api.dart';
import 'package:giapha/core/values/api_endpoint.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static String baseUrl = ApiEndpoint.domain;

  static Future<APIResponse> fetchData(String endpoint,
      {Map<String, dynamic>? params}) async {
    // Xây dựng URL với các tham số nếu có
    final uri =
        Uri.parse('$baseUrl/$endpoint').replace(queryParameters: params);

    final response = await http.get(uri, headers: {
      AuthService.apiKey: await AuthService.getApiKey(),
      AuthService.clientId: await AuthService.getClientId(),
      AuthService.accessToken: await AuthService.getAccessToken()
    });

    return APIResponse.fromJson(json.decode(response.body));
  }

  static Future<APIResponse> postData(
      String endpoint, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      body: json.encode(data),
      headers: {
        'Content-Type': 'application/json',
        AuthService.apiKey: await AuthService.getApiKey(),
        AuthService.clientId: await AuthService.getClientId(),
        AuthService.accessToken: await AuthService.getAccessToken()
      },
    );

    return APIResponse.fromJson(json.decode(response.body));
  }
}
