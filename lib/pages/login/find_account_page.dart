import 'package:flutter/material.dart';
import 'package:gaseng/widgets/gaseng_general_button.dart';
import 'package:get/get.dart';

import '../../constants/constant.dart';

class FindAccountPage extends StatelessWidget {
  const FindAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '계정찾기',
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
            GestureDetector(
              onTap: () => Get.toNamed('/login/find-account/email'),
              child: GasengGeneralButton(
                text: '아이디 찾기',
                color: primary,
                textColor: Colors.white,
              ),
            ),
            SizedBox(height: 12),
            GestureDetector(
              onTap: () => Get.toNamed('/login/find-account/password'),
              child: GasengGeneralButton(
                text: '비밀번호 변경 (비밀번호 찾기)',
                color: primary,
                textColor: Colors.white,
              ),
            ),
            SizedBox(height: 12),
            GestureDetector(
              onTap: () => Get.back(),
              child: GasengGeneralButton(
                text: '이전',
                color: Colors.white,
                textColor: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
