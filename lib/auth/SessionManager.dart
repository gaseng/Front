import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const _memId = 'memId';
  static const _accessTokenKey = 'accessToken';
  static const _refreshTokenKey = 'refreshToken';

  static Future<void> saveTokens(int memId, String accessToken, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_memId, memId.toString());
    await prefs.setString(_accessTokenKey, accessToken);
    await prefs.setString(_refreshTokenKey, refreshToken);
  }

  static Future<String?> getMemId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_memId);
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
    await prefs.remove(_accessTokenKey);
    await prefs.remove(_refreshTokenKey);
  }
}