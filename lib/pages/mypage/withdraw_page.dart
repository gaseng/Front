import 'package:flutter/material.dart';
import 'package:gaseng/constants/constant.dart';
import 'package:get/get.dart';
import 'package:gaseng/repositories/login_repository.dart';
import 'package:gaseng/widgets/gaseng_bottom_button.dart';
import 'package:gaseng/widgets/gaseng_general_button.dart';

class WithdrawPage extends StatefulWidget {
  @override
  State<WithdrawPage> createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  bool checkboxState = false;
  LoginRepository loginRepository = LoginRepository();
  bool isProcess = false;

  withdraw() async {
    if (!checkboxState) {
      kShowToast('체크박스를 확인해주세요');
      return;
    }
    setState(() {
      isProcess = true;
    });
    dynamic response = await loginRepository.withdraw();
    if (response != null) {
      kShowToast('회원 탈퇴 처리가 완료되었습니다.');
      Get.offAllNamed('/login');
    }
    setState(() {
      isProcess = false;
    });
  }

  Widget processing() {
    if (isProcess) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black45,
        child: Center(
          child: Text(
            '처리중입니다.',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      );
    } else {
      return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '회원 탈퇴',
          style: TextStyle(color: Colors.black, fontSize: 16.0),
        ),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Spacer(),
                Text(
                  '회원 탈퇴 시 더 이상 가생이 서비스 사용이 불가능하며\n탈퇴 처리됩니다.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Checkbox(
                        value: checkboxState,
                        onChanged: (state) {
                          setState(() {
                            checkboxState = state!;
                          });
                        }),
                    SizedBox(width: 12.0),
                    Text('이에 동의합니다.'),
                  ],
                ),
                SizedBox(height: 12.0),
                GestureDetector(
                  onTap: withdraw,
                  child: GasengGeneralButton(
                    text: '탈퇴',
                    color: Color(
                      0xFFCC1111,
                    ),
                  ),
                ),
              ],
            ),
          ),
          processing(),
        ],
      ),
    );
  }
}
