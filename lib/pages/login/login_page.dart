import 'package:flutter/material.dart';
import 'package:gaseng/constants/constant.dart';
import 'package:gaseng/models/login/login_request.dart';
import 'package:gaseng/pages/login/sign_up_page.dart';
import 'package:gaseng/repositories/login_repository.dart';
import 'package:get/get.dart';

import '../../widgets/gaseng_general_button.dart';
import '../../widgets/gaseng_text_field.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  LoginRepository repository = LoginRepository();

  login() async {
    // LoginRequest request = LoginRequest(
    //   email: emailController.text,
    //   password: passController.text,
    // );
    //
    // int code = await repository.login(request);
    // if (code == 200) {
    //   Get.offAllNamed('/main');
    // }
    Get.offAllNamed('/main');
  }

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
            SizedBox(height: 100.0),
            GasengTextField(
              controller: emailController,
              labelText: 'Email',
            ),
            SizedBox(height: 12.0),
            GasengTextField(
              controller: passController,
              labelText: 'Password',
              obscureText: true,
            ),
            SizedBox(height: 12.0),
            GestureDetector(
              onTap: login,
              child: GasengGeneralButton(
                text: '로그인',
                color: primary,
              ),
            ),
            SizedBox(height: 12.0),
            GestureDetector(
              onTap: () => Get.toNamed('/login/sign-up'),
              child: GasengGeneralButton(
                text: '회원가입',
                color: primary,
              ),
            ),
            SizedBox(height: 12.0),
            GestureDetector(
              onTap: () => Get.toNamed('/login/find-account'),
              child: Center(
                child: Text(
                  '계정을 잊으셨습니까?',
                  style: TextStyle(
                      color: Colors.indigo, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
