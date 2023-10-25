import 'dart:convert';

import 'package:gaseng/models/login/checklist_response.dart';

import '../auth/SessionManager.dart';
import 'package:http/http.dart' as http;

import '../models/login/checklist_request.dart';

class ChecklistRepository {
  final String baseUrl = 'https://gaseng.site/member';

  Future<ChecklistResponse?> get() async {
    String? accessToken = await SessionManager.getAccessToken();

    try {
      final Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      };

      final response = await http.get(
        Uri.parse(baseUrl),
        headers: headers,
      );

      final decodeData = utf8.decode(response.bodyBytes);
      dynamic responseJson = json.decode(decodeData);

      print(responseJson);

      return ChecklistResponse.fromJson(responseJson['data']);
    } catch (e) {
      return null;
    }
  }

  Future<int?> create(int id, ChecklistRequest request) async {
    String? accessToken = await SessionManager.getAccessToken();

    try {
      final Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      };

      final response = await http.post(
        Uri.parse("$baseUrl?memId=$id"),
        headers: headers,
        body: json.encode(request.toJson()),
      );

      final decodeData = utf8.decode(response.bodyBytes);
      dynamic responseJson = json.decode(decodeData);

      return 200;
    } catch (e) {
      return null;
    }
  }

  Future<int?> update(ChecklistRequest request) async {
    String? accessToken = await SessionManager.getAccessToken();

    try {
      final Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      };

      final response = await http.put(
        Uri.parse(baseUrl),
        headers: headers,
        body: json.encode(request.toJson()),
      );

      final decodeData = utf8.decode(response.bodyBytes);
      dynamic responseJson = json.decode(decodeData);

      return 200;
    } catch (e) {
      return null;
    }
  }
}
