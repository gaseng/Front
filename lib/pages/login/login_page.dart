import 'package:flutter/material.dart';
import 'package:gaseng/constants/constant.dart';
import 'package:gaseng/pages/login/sign_up_page.dart';
import 'package:get/get.dart';

import '../../widgets/gaseng_general_button.dart';
import '../../widgets/gaseng_text_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '가생이',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 100.0,
            ),
            GasengTextField(
              labelText: 'Email',
            ),
            SizedBox(
              height: 12.0,
            ),
            GasengTextField(
              labelText: 'Password',
            ),
            SizedBox(
              height: 12.0,
            ),
            GestureDetector(
              onTap: () => Get.offAllNamed('/main'),
              child: GasengGeneralButton(
                text: '로그인',
                color: primary,
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            GestureDetector(
              onTap: () => Get.toNamed('/login/find-account'),
              child: GasengGeneralButton(text: '회원가입', color: primary,),
            ),
          ],
        ),
      ),
    );
  }
}

