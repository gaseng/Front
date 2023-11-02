import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/constant.dart';
import '../../widgets/chat.dart';
import '../../widgets/system_chat.dart';

class ChatRoomPage extends StatelessWidget {
  const ChatRoomPage({Key? key}) : super(key: key);

  requestKyc(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text(
            'KYC 요청',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          contentPadding: EdgeInsets.all(0.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(40.0),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('상대방에게 KYC를 요청하시겠습니까?'),
                    SizedBox(height: 12.0),
                    Text(
                      '[주의사항]\n1. 상대방에게 KYC 요청이 메시지로 전달됩니다.\n2. 요청을 승낙하면 자신의 KYC가 상대방에게 전달됩니다.\n3. 충분한 대화를 통해 상대방을 신뢰할 수 있는 경우에만 요청하시기 바랍니다.',
                      style: TextStyle(color: gray08, fontSize: 12.0),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 60.0,
                      decoration: BoxDecoration(
                          color: gray06,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40.0))),
                      child: Center(
                          child: Text(
                        '취소',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 60.0,
                      decoration: BoxDecoration(
                          color: const Color(0xFF99A9FF),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(40.0))),
                      child: Center(
                          child: Text(
                        '요청',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '채팅방',
          style: TextStyle(color: Colors.black, fontSize: 16.0),
        ),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        actions: [
          Center(
            child: TextButton(
              onPressed: () {
                requestKyc(context);
              },
              child: Text(
                'KYC 요청',
                style: TextStyle(color: Colors.blue, fontSize: 12.0),
              ),
            ),
          ),
          SizedBox(
            width: 16.0,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  SystemChat(
                    mode: 4,
                  ),
                  Chat(
                      isMe: true,
                      nick: '#',
                      message: '##########'),
                  Chat(isMe: false, nick: '##########', message: '##########'),
                  Chat(isMe: false, nick: '##########', message: '##########'),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(border: Border.all(color: gray04)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 10,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                      ),
                    ),
                  ),
                  FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      backgroundColor: primary,
                    ),
                    child: Text(
                      '전송',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
