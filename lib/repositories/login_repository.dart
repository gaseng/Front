import 'dart:convert';

import 'package:gaseng/auth/SessionManager.dart';
import 'package:gaseng/models/login/login_response.dart';
import 'package:http/http.dart' as http;

import '../models/login/login_request.dart';
import '../models/login/sign_up_request.dart';

class LoginRepository {
  final String baseUrl = 'http://localhost:8080/member';

  Future<int> signUp(SignUpRequest signUpRequest) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final String requestBody = json.encode(signUpRequest.toJson());

    try {
      final response = await http.post(
        Uri.parse("$baseUrl/sign-up"),
        headers: headers,
        body: requestBody,
      );

      return response.statusCode;
    } catch (e) {
      return 400;
    }
  }

  Future<int> login(LoginRequest loginRequest) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final String requestBody = json.encode(loginRequest.toJson());

    try {
      final response = await http.post(
        Uri.parse("$baseUrl/login"),
        headers: headers,
        body: requestBody,
      );

      dynamic responseJson = json.decode(response.body);

      LoginResponse loginResponse =
          LoginResponse.fromJson(responseJson['data']);

      SessionManager.saveTokens(
        loginResponse.memId,
        loginResponse.accessToken,
        loginResponse.refreshToken,
      );

      return response.statusCode;
    } catch (e) {
      return 400;
    }
  }

  Future<int> logout(int memId) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.post(
        Uri.parse("$baseUrl/logout"),
        headers: headers,
        body: memId,
      );

      return response.statusCode;
    } catch (e) {
      return 400;
    }
  }
}
