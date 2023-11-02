import 'package:flutter/material.dart';
import 'package:gaseng/constants/constant.dart';
import 'package:gaseng/repositories/login_repository.dart';
import 'package:gaseng/utils/validator.dart';
import 'package:gaseng/widgets/gaseng_general_button.dart';
import 'package:gaseng/widgets/gaseng_text_field.dart';
import 'package:gaseng/widgets/processing.dart';
import 'package:get/get.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  LoginRepository loginRepository = LoginRepository();
  bool isProcess = false;
  late String id;

  @override
  void initState() {
    id = Get.arguments;
    super.initState();
  }

  submit() async {
    setState(() {
      isProcess = true;
    });
    if (_formKey.currentState!.validate()) {
      dynamic response = await loginRepository.pwUpdate(id, passController.text);
      if (response['data'] != null) {
        Get.toNamed('/login/find-account/change-password-result');
      } else {
        kShowToast(response['message']);
      }
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
                    labelText: '새로운 비밀번호',
                    controller: passController,
                    validator: Validator.validatePass,
                    obscureText: true,
                  ),
                  SizedBox(height: 12.0),
                  GasengTextField(
                    labelText: '새로운 비밀번호 확인',
                    controller: confirmController,
                    validator: (value) => Validator.validatePassConfirm(passController.text, value),
                    obscureText: true,
                  ),
                  SizedBox(height: 12.0),
                  GestureDetector(
                    onTap: submit,
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
          Processing(isProcess: isProcess),
        ],
      ),
    );
  }
}
