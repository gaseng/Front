import 'package:flutter/material.dart';
import 'package:gaseng/models/chat/chat_room_list_response.dart';
import 'package:gaseng/pages/chat/chat_room_page.dart';
import 'package:gaseng/repositories/chat_repository.dart';
import 'package:get/get.dart';

import '../../constants/constant.dart';
import '../../widgets/chat_room_tile.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({Key? key}) : super(key: key);

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  ChatRepository chatRepository = ChatRepository();
  late List<ChatRoomListResponse> chatList;
  Future? future;

  @override
  void initState() {
    chatList = [];
    future = getChatList(null);
    super.initState();
  }

  Future<void> getChatList(int? index) async {
    dynamic response = await chatRepository.getChatRoomList(index);
    print(response);
    if (response['data'] != null) {
      for (dynamic body in response['data']) {
        chatList.add(ChatRoomListResponse.fromJson(body));
      }
    } else {
      kShowToast(response['message']);
    }
    setState(() {

    });
  }

  Future<void> _refreshData() async {
    chatList = [];
    await getChatList(null);
    setState(() {});
  }

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
      body: FutureBuilder(
        future: future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (chatList.isEmpty) {
            return RefreshIndicator(
              onRefresh: _refreshData,
              child: ListView(
                children: [
                  SizedBox(height: 300.0),
                  Center(child: Text('채팅방이 없습니다.')),
                ],
              ),
            );
          } else {
            return RefreshIndicator(
              onRefresh: _refreshData,
              child: ListView(
                  children: chatList.map((chat) {
                return GestureDetector(
                  onTap: () {
                    Get.toNamed('/chat/room', arguments: [chat.chatRoomId])!.then((value) {
                      _refreshData();
                    });
                  },
                  child: ChatRoomTile(
                    name: chat.partnerNickname,
                    date: chat.updatedTime,
                    message: chat.message == "" || chat.message == null
                        ? "메시지가 없습니다."
                        : chat.message,
                  ),
                );
              }).toList()),
            );
          }
        },
      ),
    );
  }
}
