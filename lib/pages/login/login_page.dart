import 'package:flutter/material.dart';
import 'package:gaseng/constants/constant.dart';
import 'package:gaseng/models/login/login_request.dart';
import 'package:gaseng/pages/login/sign_up_page.dart';
import 'package:gaseng/repositories/login_repository.dart';
import 'package:gaseng/utils/validator.dart';
import 'package:get/get.dart';

import '../../widgets/gaseng_general_button.dart';
import '../../widgets/gaseng_text_field.dart';
import '../../widgets/processing.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  LoginRepository repository = LoginRepository();
  bool isProcess = false;

  login() async {
    setState(() {
      isProcess = true;
    });
    if (_formKey.currentState!.validate()) {
      LoginRequest request = LoginRequest(
        email: emailController.text,
        password: passController.text,
      );

      String? role = await repository.login(request);
      if (role != null && role == '유저') {
        Get.offAllNamed('/main');
      } else if (role != null && role == '관리자') {
        Get.offAllNamed('/admin');
      } else {
        kShowToast('아이디, 비밀번호를 다시 확인해주세요.');
      }
    }
    setState(() {
      isProcess = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: _formKey,
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
                    validator: Validator.validateEmail,
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
          ),
          Processing(isProcess: isProcess)
        ],
      ),
    );
  }
}
