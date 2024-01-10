import 'dart:convert';

import '../auth/session_manager.dart';
import 'package:http/http.dart' as http;

import '../models/sharehouse/sharehouse_list_response.dart';

class ScrapRepository {
  final String baseUrl = 'https://gaseng.site/scrap';
  // final String baseUrl = 'http://10.0.2.2:8080/member';

  Future<dynamic> getScraps(int? index, List<SharehouseListResponse> responses) async {
    String? accessToken = await SessionManager.getAccessToken();
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    String url = "";
    if (index == null) {
      url = "$baseUrl?page=10";
    } else {
      url = "$baseUrl?page=10&index=$index";
    }

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      final decodeData = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> responseData = json.decode(decodeData);

      List<dynamic> list = responseData['data'];

      for (dynamic body in list) {
        responses.add(SharehouseListResponse.fromJson(body));
      }

      return responseData;

    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<dynamic> create(int shrId) async {
    String? accessToken = await SessionManager.getAccessToken();
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    try {
      final response = await http.post(
        Uri.parse("$baseUrl/sharehouse/$shrId"),
        headers: headers,
      );

      return response.statusCode;

    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<dynamic> delete(int shrId) async {
    String? accessToken = await SessionManager.getAccessToken();
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/sharehouse/$shrId"),
        headers: headers,
      );

      return response.statusCode;

    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool?> isScrap(int shrId) async {
    String? accessToken = await SessionManager.getAccessToken();
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    try {
      final response = await http.get(
        Uri.parse("$baseUrl/sharehouse/$shrId"),
        headers: headers,
      );

      final decodeData = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> responseData = json.decode(decodeData);

      return responseData['data'];

    } catch (e) {
      print(e);
      return null;
    }
  }
}