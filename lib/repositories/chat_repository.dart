import 'dart:convert';

import 'package:gaseng/models/chat/chat_room_response.dart';
import 'package:http/http.dart' as http;

import '../auth/SessionManager.dart';

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
}