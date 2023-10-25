import 'dart:convert';

import 'package:gaseng/auth/SessionManager.dart';
import 'package:gaseng/models/login/login_response.dart';
import 'package:http/http.dart' as http;

import '../models/login/login_request.dart';
import '../models/login/sign_up_request.dart';

class LoginRepository {
  final String baseUrl = 'https://gaseng.site/member';

  Future<int?> signUp(SignUpRequest signUpRequest) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final String requestBody = json.encode(signUpRequest.toJson());

    try {
      final response = await http.post(
        Uri.parse("$baseUrl/sign-up"),
        headers: headers,
        body: requestBody,
      );

      final decodeData = utf8.decode(response.bodyBytes);
      dynamic responseJson = json.decode(decodeData);

      return responseJson['data'];
    } catch (e) {
      return null;
    }
  }

  Future<dynamic?> login(LoginRequest loginRequest) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final String requestBody = json.encode(loginRequest.toJson());
    print("$baseUrl/login");

    try {
      final response = await http.post(
        Uri.parse("$baseUrl/login"),
        headers: headers,
        body: requestBody,
      );

      final decodeData = utf8.decode(response.bodyBytes);
      dynamic responseJson = json.decode(decodeData);

      LoginResponse loginResponse =
          LoginResponse.fromJson(responseJson['data']);

      SessionManager.saveTokens(
        loginResponse.memId,
        loginResponse.status,
        loginResponse.accessToken,
        loginResponse.refreshToken,
      );

      return loginResponse.role;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<int?> logout(int memId) async {
    String? accessToken = await SessionManager.getAccessToken();
    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $accessToken'
    };

    try {
      final response = await http.post(
        Uri.parse("$baseUrl/logout"),
        headers: headers,
      );

      print(response.statusCode);
      print(response.body);

      return response.statusCode;
    } catch (e) {
      return null;
    }
  }
}
