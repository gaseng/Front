import 'package:flutter/material.dart';
import 'package:gaseng/constants/constant.dart';
import 'package:gaseng/repositories/login_repository.dart';
import 'package:gaseng/utils/validator.dart';
import 'package:gaseng/widgets/gaseng_general_button.dart';
import 'package:gaseng/widgets/gaseng_text_field.dart';
import 'package:get/get.dart';

import '../../widgets/processing.dart';

class FindPasswordPage extends StatefulWidget {
  @override
  State<FindPasswordPage> createState() => _FindPasswordPageState();
}

class _FindPasswordPageState extends State<FindPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController numController = TextEditingController();
  LoginRepository loginRepository = LoginRepository();
  bool isProcess = false;
  bool state = false;

  verifyPhone() async {
    setState(() {
      isProcess = true;
    });
    if (_formKey.currentState!.validate()) {
      dynamic response = await loginRepository.searchPw(
          emailController.text,
          nameController.text,
          phoneController.text
      );
      if (response['data'] != null) {
        setState(() {
          state = true;
        });
      } else {
        kShowToast(response['message']);
      }
    }
    setState(() {
      isProcess = false;
    });
  }

  verifyMember() async {
    setState(() {
      isProcess = true;
    });
    dynamic response = await loginRepository.verifyPw(
        phoneController.text,
        numController.text
    );
    if (response['data'] != null) {
      String id = response['data'].toString();
      Get.toNamed('/login/find-account/change-password', arguments: id);
    } else {
      kShowToast(response['message']);
    }
    setState(() {
      isProcess = false;
    });
  }

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
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GasengTextField(
                    labelText: '이메일',
                    controller: emailController,
                    validator: Validator.validateEmail,
                  ),
                  SizedBox(height: 12.0),
                  GasengTextField(
                    labelText: '이름',
                    controller: nameController,
                    validator: Validator.validateName,
                  ),
                  SizedBox(height: 12.0),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: GasengTextField(
                          labelText: '핸드폰 번호',
                          controller: phoneController,
                          validator: Validator.validatePhone,
                        ),
                      ),
                      SizedBox(width: 12.0),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: verifyPhone,
                          child: GasengGeneralButton(
                            text: state ? '전송됨' : '인증 받기',
                            color: state ? gray08 : primary,
                            textColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.0),
                  GasengTextField(
                    labelText: '인증 번호',
                    controller: numController,
                    enabled: state,
                  ),
                  SizedBox(height: 12.0),
                  GestureDetector(
                    onTap: verifyMember,
                    child: GasengGeneralButton(
                      text: '다음',
                      color: primary,
                      textColor: Colors.white,
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
