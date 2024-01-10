import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../constants/constant.dart';

class ChatRoomTile extends StatelessWidget {
  ChatRoomTile({required this.id, required this.name, required this.date, required this.message, required this.delete});
  final id;
  final name;
  final date;
  final message;
  final delete;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(border: Border.all(color: gray04)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      date,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: gray08),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Text(
                  message,
                  maxLines: 2,
                  style: TextStyle(color: gray08, fontSize: 16.0),
                ),
              ],
            ),
          ),
          const Spacer(),
          PopupMenuButton(onSelected: (String choice) {
            if (choice == '나가기') {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('정말 채팅방을 나가시겠습니까?'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('취소'),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                        TextButton(
                          child: Text('확인'),
                          onPressed: () async {
                            await delete(id);
                            Get.back();
                          },
                        ),
                      ],
                    );
                  });
            }
          }, itemBuilder: (BuildContext ctx) {
            return [
              _menuItem(text: '나가기', color: Colors.red),
            ];
          }),
        ],
      ),
    );
  }

  PopupMenuItem<String> _menuItem(
      {required String text, Color color = Colors.black}) {
    return PopupMenuItem<String>(
      enabled: true,
      onTap: () {},
      value: text,
      height: 40,
      child: Text(
        text,
        style: TextStyle(color: color),
      ),
    );
  }
}
