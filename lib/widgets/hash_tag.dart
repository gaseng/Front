import 'package:flutter/material.dart';

import '../constants/constant.dart';

class HashTag extends StatelessWidget {
  HashTag({required this.text});
  final text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      margin: EdgeInsets.only(right: 8.0),
      decoration: BoxDecoration(
        color: gray04,
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      child: Text(text, style: TextStyle(fontSize: 12.0)),
    );
  }
}
