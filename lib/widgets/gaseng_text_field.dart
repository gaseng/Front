import 'package:flutter/material.dart';

import '../constants/constant.dart';

class GasengTextField extends StatelessWidget {
  GasengTextField({required this.labelText});

  String labelText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: null,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: gray08),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: gray06)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: gray06)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: gray06)),
      ),
      keyboardType: TextInputType.multiline,
    );
  }
}
