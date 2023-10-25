import 'package:flutter/material.dart';
import 'package:gaseng/models/login/sign_up_request.dart';
import 'package:gaseng/widgets/gaseng_general_button.dart';
import 'package:gaseng/widgets/gaseng_text_field.dart';
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

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      SignUpRequest request = SignUpRequest(
        email: emailController.text,
        password: passController.text,
        name: nameController.text,
        nickname: nickController.text,
        sex: sex,
        phone: phoneController.text,
      );

      int? memId = await repository.signUp(request);
      if (memId != null) {
        Get.offAllNamed('/login/checklist', arguments: memId);
      }
    }
  }

  String? _validateEmail(String? value) {
    if (value!.isEmpty) {
      return '이메일을 입력하세요.';
    }
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    if (!emailRegExp.hasMatch(value!)) {
      return '유효한 이메일 주소를 입력하세요.';
    }
    return null;
  }

  String? _validatePass(String? value) {
    if (value!.isEmpty) {
      return '패스워드를 입력하세요.';
    }
    return null;
  }

  String? _validatePassConfirm(String? value) {
    if (passController.text != value) {
      return '비밀번호가 같지 않습니다.';
    }
    return null;
  }

  String? _validateName(String? value) {
    if (value!.isEmpty) {
      return '이름을 입력하세요.';
    }
    return null;
  }

  String? _validateNick(String? value) {
    if (value!.isEmpty) {
      return '닉네임을 입력하세요.';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value!.isEmpty) {
      return '핸드폰 번호를 입력하세요.';
    }
    value = value!.replaceAll("-", "");
    if (value.length != 11) {
      return '핸드폰 번호는 11글자여야 합니다.';
    }

    if (!value!.contains(RegExp(r'^[0-9]+$'))) {
      return '숫자만 입력하세요.';
    }
    return null;
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
      body: SingleChildScrollView(
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
                  validator: _validateEmail,
                ),
                SizedBox(height: 12),
                GasengTextField(
                  controller: passController,
                  labelText: '비밀번호',
                  obscureText: true,
                  validator: _validatePass,
                ),
                SizedBox(height: 12),
                GasengTextField(
                  controller: passConfirmController,
                  labelText: '비밀번호 확인',
                  obscureText: true,
                  validator: _validatePassConfirm,
                ),
                SizedBox(height: 12),
                GasengTextField(
                  controller: nameController,
                  labelText: '이름',
                  validator: _validateName,
                ),
                SizedBox(height: 12),
                GasengTextField(
                  controller: nickController,
                  labelText: '닉네임',
                  validator: _validateNick,
                ),
                SizedBox(height: 12),
                GasengTextField(
                  controller: phoneController,
                  labelText: '핸드폰',
                  validator: _validatePhone,
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
    );
  }
}
