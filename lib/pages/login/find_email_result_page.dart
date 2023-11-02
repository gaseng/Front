import 'package:flutter/material.dart';
import 'package:gaseng/constants/constant.dart';
import 'package:gaseng/widgets/gaseng_general_button.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';

class FindEmailResultPage extends StatefulWidget {
  @override
  State<FindEmailResultPage> createState() => _FindEmailResultPageState();
}

class _FindEmailResultPageState extends State<FindEmailResultPage> {
  String email = "";

  @override
  void initState() {
    String dbEmail = Get.arguments;
    email = maskEmail(dbEmail);
    super.initState();
  }

  String maskEmail(String email) {
    // a*@naver.com
    if (email.contains('@')) {
      List<String> parts = email.split('@');
      if (parts[0].length == 2 || parts[0].length == 3) {
        return parts[0].substring(0, 1) + '*' + parts[0].substring(2) + '@' + parts[1];
      } else if (parts[0].length > 3) {
        String maskedId = parts[0].substring(0, parts[0].length - 3) + '***';
        return maskedId + '@' + parts[1];
      }
    }
    return email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '아이디 찾기',
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '가생이에 등록된 이메일은\n${email} 입니다.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 60.0),
            GestureDetector(
              onTap: () => Get.offAllNamed('/login'),
              child: GasengGeneralButton(
                text: '로그인',
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
