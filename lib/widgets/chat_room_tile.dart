import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/constant.dart';

class ChatRoomTile extends StatelessWidget {
  ChatRoomTile({required this.name, required this.date, required this.message});
  final name;
  final date;
  final message;

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
          Icon(Icons.more_vert, color: gray08,)
        ],
      ),
    );
  }
}
