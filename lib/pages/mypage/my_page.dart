import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gaseng/auth/SessionManager.dart';
import 'package:gaseng/repositories/login_repository.dart';
import 'package:get/get.dart';

import '../../constants/constant.dart';

class MyPage extends StatefulWidget {
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  LoginRepository loginRepository = LoginRepository();
  String nickname = "";
  String email = "";

  @override
  void initState() {
    getNickname();
    super.initState();
  }

  void getNickname() async {
    String? nick = await SessionManager.getNickname();
    String? em = await SessionManager.getEmail();
    setState(() {
      nickname = nick!;
      email = em!;
    });
  }

  void logout() async {
    String? memId = await SessionManager.getMemId();
    if (memId != null) {
      int? code = await loginRepository.logout(int.parse(memId));
      if (code != null && code == 200) {
        Get.offAllNamed('/login');
      }
    }
  }

  withdraw() {
    Get.toNamed('/mypage/withdraw');
  }

  checkMemberStatus() async {
    String? status = await SessionManager.getStatus();

    if (status == '노멀') {
      Get.toNamed('/kyc/card/info');
    } else if (status == '대기') {
      kShowToast('KYC 신청하셨습니다. 승인까지 기다려주세요.');
    } else if (status == '거절') {
      kShowToast('KYC 거절된 이력이 있습니다.');
    } else {
      kShowToast('이미 승인되었습니다.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '마이페이지',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nickname,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.0),
                Text(
                  email,
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 60.0),
            Text('메뉴', style: TextStyle(color: gray08, fontSize: 12.0)),
            SizedBox(height: 24.0),
            GestureDetector(
              onTap: () => Get.toNamed('/mypage/sharehouse'),
              child: MyPageMenu(textIcon: '📝', text: '내가 쓴 쉐어하우스 글 조회'),
            ),
            GestureDetector(
              onTap: () => Get.toNamed('/mypage/scrap'),
              child: MyPageMenu(
                textIcon: '📔',
                text: '스크랩 게시물 조회',
              ),
            ),
            GestureDetector(
              onTap: checkMemberStatus,
              child: MyPageMenu(
                textIcon: '🪪',
                text: 'KYC 인증하기',
              ),
            ),
            GestureDetector(
              onTap: () => Get.toNamed('/mypage/checklist'),
              child: MyPageMenu(
                textIcon: '✅',
                text: '체크리스트 수정',
              ),
            ),
            GestureDetector(
              onTap: logout,
              child: MyPageMenu(
                textIcon: '🚪',
                text: '로그아웃',
              ),
            ),
            GestureDetector(
              onTap: withdraw,
              child: MyPageMenu(
                textIcon: '❌',
                text: '회원 탈퇴',
                isDivided: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyPageMenu extends StatelessWidget {
  MyPageMenu(
      {required this.textIcon, required this.text, this.isDivided = true});

  final textIcon;
  final text;
  final isDivided;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(6.0),
          color: Colors.transparent,
          child: Row(
            children: [
              Text(textIcon),
              SizedBox(width: 12.0),
              Text(
                text,
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
        isDivided ? const Divider() : const SizedBox(),
      ],
    );
  }
}
