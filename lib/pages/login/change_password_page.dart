import 'package:flutter/material.dart';
import 'package:gaseng/constants/constant.dart';
import 'package:gaseng/widgets/gaseng_general_button.dart';
import 'package:gaseng/widgets/gaseng_text_field.dart';
import 'package:get/get.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '비밀번호 찾기',
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
            GasengTextField(labelText: '새로운 비밀번호'),
            SizedBox(height: 12.0),
            GasengTextField(labelText: '새로운 비밀번호 확인'),
            SizedBox(height: 12.0),
            GestureDetector(
              onTap: () =>
                  Get.toNamed('/login/find-account/change-password-result'),
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
