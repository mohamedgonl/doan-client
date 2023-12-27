import 'dart:convert';
import 'package:giapha/core/api/auth_service.dart';
import 'package:giapha/core/api/response_api.dart';
import 'package:giapha/core/values/api_endpoint.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static String baseUrl = ApiEndpoint.local;

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

  static Future<String?> uploadSingleImage(String imagePath) async {
    final request = http.MultipartRequest(
        "POST", Uri.parse("$baseUrl/${ApiEndpoint.uploadImage}"));
    request.files.add(await http.MultipartFile.fromPath('image', imagePath));
    request.headers[AuthService.apiKey] = await AuthService.getApiKey();
    request.headers[AuthService.clientId] = await AuthService.getClientId();
    request.headers[AuthService.accessToken] = await AuthService.getAccessToken();

    try {
      final response = await request.send();
      final responseData = await response.stream.toBytes();
      final responseString = utf8.decode(responseData);
      APIResponse apiResponse =
          APIResponse.fromJson(json.decode(responseString));
      if (apiResponse.status) {
        return apiResponse.metadata["image_url"];
      } else
        return "";
    } catch (e) {
      print("Upload file fail " + e.toString());
      return "";
    }
  }
}
