import 'package:flutter/material.dart';

import '../constants/constant.dart';

class GasengTextField extends StatelessWidget {
  GasengTextField({
    required this.labelText,
    this.controller,
    this.validator,
    this.keyboardType,
    this.obscureText = false
  });

  String labelText;
  TextEditingController? controller;
  String? Function(String?)? validator;
  TextInputType? keyboardType;
  bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
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
      keyboardType: keyboardType ?? TextInputType.none,
    );
  }
}
