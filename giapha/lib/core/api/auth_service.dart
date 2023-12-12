import 'dart:convert';

import 'package:giapha/features/access/data/models/user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String userInfoKey = 'user_info';
  static const String clientId = 'x-client-id';
  static const String apiKey = 'x-api-key';
  static const String accessToken = "Authorization";
  static const String defaultApiKey =
      "7a3a073123d687ade8f5732db401692e0cf00c94a4e34014a42b2c7c492c1c3f77b6e49ef31722857b98e468f2883bcbf3374768c1a3100f52d8cdeffc50bb91";

  // Lưu access token vào SharedPreferences
  static Future<void> saveAccessToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(accessToken, token);
  }

  // Lấy access token từ SharedPreferences
  static Future<String> getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(accessToken) ?? "";
  }

  // Lưu x-api-key vào SharedPreferences
  static Future<void> saveApiKey(String apiKey) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(apiKey, apiKey);
  }

  // Lấy x-api-key từ SharedPreferences
  static Future<String> getApiKey() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(apiKey) ?? defaultApiKey;
  }

  // Lưu x-api-key vào SharedPreferences
  static Future<void> saveClientId(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(clientId, id);
  }

  // Lấy x-api-key từ SharedPreferences
  static Future<String> getClientId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(clientId) ?? "";
  }

  // Lưu thông tin người dùng vào local storage
  static Future<void> saveUserInfo(UserInfo userInfo) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final Map<String, dynamic> userInfoMap = userInfo.toJson();
    final String userInfoJson = json.encode(userInfoMap);
    await prefs.setString(userInfoKey, userInfoJson);
    await prefs.setString(clientId, userInfo.userId ?? "");
  }

  // Lấy thông tin người dùng từ local storage
  static Future<UserInfo?> getUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userInfoJson = prefs.getString(userInfoKey);

    if (userInfoJson != null) {
      final Map<String, dynamic> userInfoMap = json.decode(userInfoJson);
      return UserInfo.fromJson(userInfoMap);
    }

    return null;
  }
}
