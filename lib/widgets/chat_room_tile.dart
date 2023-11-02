import 'package:flutter/material.dart';

import '../constants/constant.dart';

class ChatRoomTile extends StatelessWidget {
  const ChatRoomTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(border: Border.all(color: gray04)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 24.0,
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '######',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12.0),
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      '##',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                          color: gray08),
                    ),
                  ],
                ),
                Text(
                  '#######',
                  style: TextStyle(color: gray08, fontSize: 12.0),
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
