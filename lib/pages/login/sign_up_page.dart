import 'package:flutter/material.dart';
import 'package:gaseng/widgets/gaseng_general_button.dart';
import 'package:gaseng/widgets/gaseng_text_field.dart';

import '../../constants/constant.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GasengTextField(
              labelText: '이메일',
            ),
            SizedBox(
              height: 12,
            ),
            GasengTextField(
              labelText: '비밀번호',
            ),
            SizedBox(
              height: 12,
            ),
            GasengTextField(
              labelText: '비밀번호 확인',
            ),
            SizedBox(
              height: 12,
            ),
            GasengTextField(
              labelText: '이름',
            ),
            SizedBox(
              height: 12,
            ),
            GasengTextField(
              labelText: '닉네임',
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              '성별',
              style: TextStyle(color: gray08),
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Expanded(child: GasengGeneralButton(text: '남', color: primary, textColor: Colors.white,)),
                SizedBox(
                  width: 12.0,
                ),
                Expanded(child: GasengGeneralButton(text: '여', color: Colors.white)),
              ],
            ),
            SizedBox(height: 30.0,),
            GasengGeneralButton(text: '회원가입', color: primary, textColor: Colors.white)
          ],
        ),
      ),
    );
  }
}
