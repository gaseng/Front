import 'package:flutter/material.dart';
import 'package:gaseng/constants/constant.dart';
import 'package:gaseng/widgets/gaseng_general_button.dart';
import 'package:get/get.dart';

class ChangePasswordResultPage extends StatelessWidget {
  const ChangePasswordResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '비밀번호 변경',
          style: TextStyle(color: Colors.black, fontSize: 16.0),
        ),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '비밀번호가 변경되었습니다.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 40.0),
            GestureDetector(
              onTap: () => Get.offAllNamed('/login'),
              child: GasengGeneralButton(
                text: '다음',
                color: primary,
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
