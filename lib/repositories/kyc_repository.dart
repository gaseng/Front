import 'dart:convert';

import 'package:gaseng/models/kyc/kyc_notification_response.dart';
import 'package:gaseng/models/kyc/kyc_save_request.dart';
import 'package:gaseng/models/kyc/kyc_submit_request.dart';
import 'package:intl/intl.dart';

import '../auth/session_manager.dart';
import 'package:http/http.dart' as http;

import '../models/kyc/customer.dart';
import '../models/kyc/kyc_require_response.dart';
import '../models/kyc/kyc_require_summary_response.dart';

class KycRepository {
  final String baseUrl = 'https://gaseng.site/kyc';

  Future<dynamic> submit(KycSubmitRequest kycSubmitRequest) async {
    String? accessToken = await SessionManager.getAccessToken();
    final url = Uri.parse("$baseUrl/submit");
    String j = "";
    if (kycSubmitRequest.job == "학생") {
      j = "STUDENT";
    } else if (kycSubmitRequest.job == "직장인") {
      j = "OFFICEWORKER";
    } else if (kycSubmitRequest.job == "무직") {
      j = "UNEMPLOYED";
    }
    String formattedDate = DateFormat('yyyy-MM-dd').format(kycSubmitRequest.birth);

    try {
      final request = http.MultipartRequest('POST', url)
        ..fields['name'] = kycSubmitRequest.name
        ..fields['birth'] = formattedDate
        ..fields['address'] = kycSubmitRequest.address
        ..fields['detail'] = kycSubmitRequest.detail
        ..fields['job'] = j
        ..headers['Content-Type'] = 'application/json'
        ..headers['Authorization'] = 'Bearer $accessToken';

      request.files.add(kycSubmitRequest.card);
      request.files.add(kycSubmitRequest.face);

      final response = await request.send();

      var content = StringBuffer();
      await for (var chunk in response.stream) {
        content.write(String.fromCharCodes(chunk));
      }
      print(content.toString());

      return response.statusCode;

    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<dynamic> getAll(List<KycRequireSummaryResponse> responses) async {
    String? accessToken = await SessionManager.getAccessToken();
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    try {
      final response = await http.get(
        Uri.parse("$baseUrl/all"),
        headers: headers,
      );

      final decodeData = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> responseData = json.decode(decodeData);

      List<dynamic> list = responseData['data'];

      for (dynamic body in list) {
        responses.add(KycRequireSummaryResponse.fromJson(body));
      }

      return responseData;

    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<dynamic> getKycRequire(int id) async {
    String? accessToken = await SessionManager.getAccessToken();
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    try {
      final response = await http.get(
        Uri.parse("$baseUrl?kycrId=$id"),
        headers: headers,
      );

      final decodeData = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> responseData = json.decode(decodeData);

      return KycRequireResponse.fromJson(responseData['data']);

    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<dynamic> save(int kycrId, KycSaveRequest kycSaveRequest) async {
    String? accessToken = await SessionManager.getAccessToken();

    final Uri url = Uri.parse('$baseUrl?kycrId=$kycrId');
    final http.MultipartRequest request = http.MultipartRequest('POST', url);

    request.fields['status'] = kycSaveRequest.status;
    request.fields['description'] = kycSaveRequest.description;
    request.headers['Content-Type'] = 'application/json';
    request.headers['Authorization'] = 'Bearer $accessToken';

    final http.StreamedResponse response = await request.send();

    var content = StringBuffer();
    await for (var chunk in response.stream) {
      content.write(String.fromCharCodes(chunk));
    }
    print(content.toString());

    return response.statusCode;

  }

  Future<dynamic> getData(int id) async {
    String? accessToken = await SessionManager.getAccessToken();
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    try {
      final response = await http.get(
        Uri.parse("$baseUrl/evm?id=$id"),
        headers: headers,
      );

      final decodeData = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> responseData = json.decode(decodeData);

      return Customer.fromJson(responseData['data']);

    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<dynamic> getNotification() async {
    String? accessToken = await SessionManager.getAccessToken();
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    try {
      final response = await http.get(
        Uri.parse("$baseUrl/notification"),
        headers: headers,
      );

      final decodeData = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> responseData = json.decode(decodeData);

      List<KycNotificationResponse> list = [];
      for (dynamic body in responseData['data']) {
        list.add(KycNotificationResponse.fromJson(body));
      }

      return list;

    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<int?> getCriminalRecord(int kycrId) async {
    String? accessToken = await SessionManager.getAccessToken();
    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $accessToken'
    };

    try {
      final response = await http.get(
        Uri.parse("$baseUrl/$kycrId/criminal-records"),
        headers: headers,
      );

      final decodeData = utf8.decode(response.bodyBytes);
      dynamic responseJson = json.decode(decodeData);
      print(responseJson);

      return responseJson['data'];
    } catch (e) {
      return null;
    }
  }
}