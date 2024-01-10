import 'package:camera/camera.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SessionManager {
  static const _memId = 'memId';
  static const _memName = 'memName';
  static const _nickname = 'nickname';
  static const _email = 'email';
  static const _status = 'status';
  static const _accessTokenKey = 'accessToken';
  static const _refreshTokenKey = 'refreshToken';
  static http.MultipartFile? card;
  static http.MultipartFile? face;

  static Future<void> saveTokens(int memId, String nickname, String email, String status, String accessToken, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_memId, memId.toString());
    await prefs.setString(_nickname, nickname);
    await prefs.setString(_email, email);
    await prefs.setString(_status, status);
    await prefs.setString(_accessTokenKey, accessToken);
    await prefs.setString(_refreshTokenKey, refreshToken);
  }

  static Future<void> toWait() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_status);
    await prefs.setString(_status, "대기");
  }

  static Future<String?> getMemId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_memId);
  }

  static Future<String?> getNickname() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_nickname);
  }

  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_email);
  }

  static Future<String?> getStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_status);
  }

  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  static Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }

  static Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_memId);
    await prefs.remove(_status);
    await prefs.remove(_accessTokenKey);
    await prefs.remove(_refreshTokenKey);
  }
}