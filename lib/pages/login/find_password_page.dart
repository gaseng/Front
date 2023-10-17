import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/constant.dart';
import '../../widgets/gaseng_general_button.dart';
import '../../widgets/gaseng_text_field.dart';

class FindPasswordPage extends StatelessWidget {
  const FindPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '비밀번호 찾',
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
            GasengTextField(labelText: '이메일'),
            SizedBox(height: 12.0),
            GasengTextField(labelText: '이름'),
            SizedBox(height: 12.0),
            Row(
              children: [
                Expanded(flex: 3, child: GasengTextField(labelText: '핸드폰 번호')),
                SizedBox(width: 12.0),
                Expanded(
                    flex: 1,
                    child: GasengGeneralButton(
                      text: '인증 받기',
                      color: primary,
                      textColor: Colors.white,
                    ))
              ],
            ),
            SizedBox(height: 12.0),
            GasengTextField(labelText: '인증 번호'),
            SizedBox(height: 12.0),
            GestureDetector(
              onTap: () => Get.toNamed('/login/find-account/change-password'),
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
