import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/constant.dart';

class Chat extends StatelessWidget {
  Chat({required this.isMe, required this.nick, required this.message});

  final bool isMe;
  final String nick;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isMe ? const Spacer() : const SizedBox(),
        isMe
            ? const SizedBox()
            : CircleAvatar(
          radius: 24.0,
          backgroundColor: gray08,
        ),
        isMe ? const SizedBox() : const SizedBox(width: 12.0),
        Column(
          crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(isMe ? '나' : nick,
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 200.w),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                margin: EdgeInsets.only(bottom: 20.0),
                decoration: BoxDecoration(
                  color: isMe ? Color(0XFFD9E3FF) : gray06,
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
                child: Text(message),
              ),
            ),
          ],
        ),
        isMe ? const SizedBox(width: 12.0) : const SizedBox(),
        isMe
            ? CircleAvatar(
          radius: 24.0,
          backgroundColor: gray08,
        )
            : const SizedBox()
      ],
    );
  }
}