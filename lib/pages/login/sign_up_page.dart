import 'package:flutter/material.dart';
import 'package:gaseng/models/login/sign_up_request.dart';
import 'package:gaseng/utils/validator.dart';
import 'package:gaseng/widgets/gaseng_general_button.dart';
import 'package:gaseng/widgets/gaseng_text_field.dart';
import 'package:gaseng/widgets/processing.dart';
import 'package:get/get.dart';

import '../../constants/constant.dart';
import '../../repositories/login_repository.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController passConfirmController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController nickController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  LoginRepository repository = LoginRepository();
  int sex = 0;
  bool isProcess = false;

  void _submitForm() async {
    setState(() {
      isProcess = true;
    });
    if (_formKey.currentState!.validate()) {
      SignUpRequest request = SignUpRequest(
        email: emailController.text,
        password: passController.text,
        name: nameController.text,
        nickname: nickController.text,
        sex: sex,
        phone: phoneController.text,
      );

      dynamic response = await repository.signUp(request);
      if (response['data'] == null) {
        kShowToast(response['message']);
      } else {
        dynamic data = response['data'];
        if (data != null) {
          Get.offAllNamed('/login/checklist', arguments: data);
        }
      }
    }
    setState(() {
      isProcess = false;
    });
  }

  toggle() {
    setState(() {
      if (sex == 0) {
        sex = 1;
      } else {
        sex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '회원가입',
          style: TextStyle(color: Colors.black, fontSize: 16.0),
        ),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GasengTextField(
                      controller: emailController,
                      labelText: '이메일',
                      validator: Validator.validateEmail,
                    ),
                    SizedBox(height: 12),
                    GasengTextField(
                      controller: passController,
                      labelText: '비밀번호',
                      obscureText: true,
                      validator: Validator.validatePass,
                    ),
                    SizedBox(height: 12),
                    GasengTextField(
                      controller: passConfirmController,
                      labelText: '비밀번호 확인',
                      obscureText: true,
                      validator: (value) => Validator.validatePassConfirm(passController.text, value),
                    ),
                    SizedBox(height: 12),
                    GasengTextField(
                      controller: nameController,
                      labelText: '이름',
                      validator: Validator.validateName,
                    ),
                    SizedBox(height: 12),
                    GasengTextField(
                      controller: nickController,
                      labelText: '닉네임',
                      validator: Validator.validateNick,
                    ),
                    SizedBox(height: 12),
                    GasengTextField(
                      controller: phoneController,
                      labelText: '핸드폰',
                      validator: Validator.validatePhone,
                    ),
                    SizedBox(height: 12),
                    Text(
                      '성별',
                      style: TextStyle(color: gray08),
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: toggle,
                            child: GasengGeneralButton(
                              text: '남',
                              color: sex == 0 ? primary : Colors.white,
                              textColor: sex == 0 ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.0),
                        Expanded(
                          child: GestureDetector(
                            onTap: toggle,
                            child: GasengGeneralButton(
                              text: '여',
                              color: sex == 1 ? primary : Colors.white,
                              textColor: sex == 1 ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.0),
                    GestureDetector(
                      onTap: _submitForm,
                      child: GasengGeneralButton(
                          text: '등록', color: primary, textColor: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ),
          Processing(isProcess: isProcess)
        ],
      ),
    );
  }
}
