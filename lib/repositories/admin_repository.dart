import 'dart:convert';

import 'package:gaseng/models/user/account_response.dart';
import 'package:gaseng/models/user/member_list_summary.dart';
import 'package:http/http.dart' as http;

import '../auth/SessionManager.dart';

class AdminRepository {
  final String baseUrl = 'https://gaseng.site/member';

  Future<List<MemberListSummary>> getMemberList(int? index, List<MemberListSummary> responses) async {
    String? accessToken = await SessionManager.getAccessToken();
    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $accessToken'
    };

    String url = "";

    if (index != null) {
      url = "$baseUrl?page=10&index=$index";
    } else {
      url = "$baseUrl?page=10";
    }

    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    final decodeData = utf8.decode(response.bodyBytes);
    dynamic responseJson = json.decode(decodeData);
    List<dynamic> memberList = responseJson['data']['members'];

    for (dynamic member in memberList) {
      responses.add(MemberListSummary.fromJson(member));
    }

    return responses;
  }

  Future<AccountResponse?> getAccount(int memId) async {
    String? accessToken = await SessionManager.getAccessToken();
    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $accessToken'
    };

    try {
      final response = await http.get(
        Uri.parse("$baseUrl/$memId"),
        headers: headers,
      );

      final decodeData = utf8.decode(response.bodyBytes);
      dynamic responseJson = json.decode(decodeData);

      return AccountResponse.fromJson(responseJson['data']);
    } catch (e) {
      return null;
    }
  }

  Future<int?> toNormal(int memId) async {
    String? accessToken = await SessionManager.getAccessToken();
    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $accessToken'
    };

    try {
      final response = await http.patch(
        Uri.parse("$baseUrl/normal/$memId"),
        headers: headers,
      );

      final decodeData = utf8.decode(response.bodyBytes);
      dynamic responseJson = json.decode(decodeData);

      return responseJson['data'];
    } catch (e) {
      return null;
    }
  }

  Future<int?> toReject(int memId) async {
    String? accessToken = await SessionManager.getAccessToken();
    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $accessToken'
    };

    try {
      final response = await http.patch(
        Uri.parse("$baseUrl/reject/$memId"),
        headers: headers,
      );

      final decodeData = utf8.decode(response.bodyBytes);
      dynamic responseJson = json.decode(decodeData);

      return responseJson['data'];
    } catch (e) {
      return null;
    }
  }
}