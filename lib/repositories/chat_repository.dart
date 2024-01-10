import 'dart:convert';

import 'package:gaseng/models/chat/chat_room_create_response.dart';
import 'package:http/http.dart' as http;

import '../auth/session_manager.dart';

class ChatRepository {
  final String baseUrl = 'https://gaseng.site/chat';

  Future<dynamic> create(int shrId) async {
    String? accessToken = await SessionManager.getAccessToken();

    try {
      final Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      };

      final response = await http.post(
        Uri.parse("$baseUrl?shrId=$shrId"),
        headers: headers,
      );

      final decodeData = utf8.decode(response.bodyBytes);
      dynamic responseJson = json.decode(decodeData);

      return responseJson;
    } catch (e) {
      return null;
    }
  }

  Future<dynamic> getChatRoomList(int? index) async {
    String? accessToken = await SessionManager.getAccessToken();

    try {
      final Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      };

      String url = "";
      if (index == null) {
        url = "$baseUrl?page=10";
      } else {
        url = "$baseUrl?page=10&index=$index";
      }

      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      final decodeData = utf8.decode(response.bodyBytes);
      dynamic responseJson = json.decode(decodeData);

      return responseJson;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<dynamic> updateMessage(int chatRoomId, String message) async {
    String? accessToken = await SessionManager.getAccessToken();

    try {
      final Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      };

      final response = await http.patch(
        Uri.parse("$baseUrl/$chatRoomId"),
        headers: headers,
        body: message
      );

      final decodeData = utf8.decode(response.bodyBytes);
      dynamic responseJson = json.decode(decodeData);
      print(responseJson);

      return response.statusCode;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<dynamic> delete(int chatRoomId) async {
    String? accessToken = await SessionManager.getAccessToken();

    try {
      final Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      };

      final response = await http.delete(
          Uri.parse("$baseUrl/$chatRoomId"),
          headers: headers,
      );

      final decodeData = utf8.decode(response.bodyBytes);
      dynamic responseJson = json.decode(decodeData);
      print(responseJson);

      return responseJson;
    } catch (e) {
      print(e);
      return null;
    }
  }
}