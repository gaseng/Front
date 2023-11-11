import 'package:flutter/material.dart';
import 'package:gaseng/constants/constant.dart';

class GasengGeneralButton extends StatelessWidget {
  GasengGeneralButton({required this.text, required this.color, this.textColor = Colors.white});

  String text;
  Color color;
  Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        border: Border.all(color: gray06)
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}