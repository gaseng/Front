import 'package:flutter/material.dart';
import 'package:gaseng/pages/chat/chat_room_page.dart';
import 'package:get/get.dart';

import '../../constants/constant.dart';
import '../../widgets/chat_room_tile.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '채팅 목록',
          style: TextStyle(color: Colors.black, fontSize: 16.0),
        ),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          GestureDetector(
            onTap: () => Get.toNamed('/chat/room'),
            child: ChatRoomTile(),
          ),
        ],
      ),
    );
  }
}
