import 'dart:convert';
import 'dart:io';

import 'package:gaseng/models/sharehouse/sharehouse_delete_request.dart';
import 'package:gaseng/models/sharehouse/sharehouse_request.dart';
import 'package:gaseng/models/sharehouse/sharehouse_response.dart';
import 'package:gaseng/models/sharehouse/sharehouse_update_request.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../auth/SessionManager.dart';
import '../models/sharehouse/sharehouse_detail_response.dart';
import '../models/sharehouse/sharehouse_list_response.dart';

class SharehouseRepository {
  final String baseUrl = 'https://gaseng.site/sharehouse';

  Future<dynamic> getAll(int? index, List<SharehouseResponse> responses) async {
    String? accessToken = await SessionManager.getAccessToken();
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    String url = "";
    if (index == null) {
      url = "$baseUrl/all?page=10";
    } else {
      url = "$baseUrl/all?page=10&index=$index";
    }

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      final decodeData = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> responseData = json.decode(decodeData);
      List<dynamic> sharehouses = responseData['data'];

      for (dynamic sharehouse in sharehouses) {
        responses.add(SharehouseResponse.fromJson(sharehouse));
      }

      return;

    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<SharehouseDetailResponse?> get(int id) async {
    String? accessToken = await SessionManager.getAccessToken();
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    try {
      final response = await http.get(
        Uri.parse("$baseUrl?id=$id"),
        headers: headers,
      );

      final decodeData = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> responseData = json.decode(decodeData);
      return SharehouseDetailResponse.fromJson(responseData['data']);

    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<SharehouseListResponse>> my() async {
    String? accessToken = await SessionManager.getAccessToken();
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    String url = "$baseUrl/my-share";

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      final decodeData = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> responseData = json.decode(decodeData);
      List<dynamic> sharehouses = responseData['data'];
      List<SharehouseListResponse> responses = [];

      for (dynamic sharehouse in sharehouses) {
        responses.add(SharehouseListResponse.fromJson(sharehouse));
      }

      return responses;

    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<int?> create(SharehouseRequest sharehouseRequest, http.MultipartFile poster) async {
    final url = Uri.parse(baseUrl);

    String? accessToken = await SessionManager.getAccessToken();

    try {
      final request = http.MultipartRequest('POST', url)
        ..fields['shrTitle'] = sharehouseRequest.shrTitle
        ..fields['shrDescription'] = sharehouseRequest.shrDescription
        ..fields['shrAddress'] = sharehouseRequest.shrAddress
        ..fields['shrAddressDetail'] = sharehouseRequest.shrAddressDetail
        ..headers['Content-Type'] = 'application/json'
        ..headers['Authorization'] = 'Bearer $accessToken';

      for (http.MultipartFile xFile in sharehouseRequest.lists) {
        request.files.add(xFile);
      }
      request.files.add(poster);

      final response = await request.send();

      var content = StringBuffer();
      await for (var chunk in response.stream) {
        content.write(String.fromCharCodes(chunk));
      }
      print(content.toString());

      return response.statusCode;

    } catch (e) {
      return null;
    }
  }

  Future<int?> update(SharehouseUpdateRequest request) async {
    String? accessToken = await SessionManager.getAccessToken();
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    try {
      final response = await http.put(
        Uri.parse(baseUrl),
        headers: headers,
        body: json.encode(request.toJson())
      );

      final decodeData = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> responseData = json.decode(decodeData);
      print(responseData);

      return 200;

    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<int?> delete(SharehouseDeleteRequest request) async {
    String? accessToken = await SessionManager.getAccessToken();
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    try {
      final response = await http.delete(
          Uri.parse(baseUrl),
          headers: headers,
          body: json.encode(request.toJson())
      );

      final decodeData = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> responseData = json.decode(decodeData);
      print(responseData);

      return 200;

    } catch (e) {
      print(e);
      return null;
    }
  }
}