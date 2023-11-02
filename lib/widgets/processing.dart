import 'package:flutter/material.dart';

class Processing extends StatelessWidget {
  Processing({required this.isProcess});
  final isProcess;

  Widget processing() {
    if (isProcess) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black45,
        child: Center(
          child: Text(
            '처리중입니다.',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      );
    } else {
      return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return processing();
  }
}
