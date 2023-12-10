import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String clientId = 'x-client-id';
  static const String apiKey = 'x-api-key';
  static const String accessToken = "access-token";

  // Lưu access token vào SharedPreferences
  static Future<void> saveAccessToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(accessToken, token);
  }

  // Lấy access token từ SharedPreferences
  static Future<String?> getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(accessToken);
  }

  // Lưu x-api-key vào SharedPreferences
  static Future<void> saveApiKey(String apiKey) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(apiKey, apiKey);
  }

  // Lấy x-api-key từ SharedPreferences
  static Future<String> getApiKey() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(apiKey) ?? "api-key-123";
  }
}
