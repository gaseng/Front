import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaseng/pages/chat/chat_list_page.dart';
import 'package:gaseng/pages/chat/chat_room_page.dart';
import 'package:gaseng/pages/kyc/kyc_card_info_page.dart';
import 'package:gaseng/pages/kyc/kyc_certification_page.dart';
import 'package:gaseng/pages/mypage/check_list_modify_page.dart';
import 'package:gaseng/pages/mypage/my_page.dart';
import 'package:gaseng/pages/mypage/my_sharehouse_page.dart';
import 'package:gaseng/pages/mypage/scrap_sharehouse_page.dart';
import 'package:gaseng/pages/sharehouse/notification_page.dart';
import 'package:gaseng/pages/main_template.dart';
import 'package:gaseng/pages/login/change_password_page.dart';
import 'package:gaseng/pages/login/change_password_result_page.dart';
import 'package:gaseng/pages/login/check_list_page.dart';
import 'package:gaseng/pages/login/find_account_page.dart';
import 'package:gaseng/pages/login/find_email_page.dart';
import 'package:gaseng/pages/login/find_email_result_page.dart';
import 'package:gaseng/pages/login/find_password_page.dart';
import 'package:gaseng/pages/login/login_page.dart';
import 'package:gaseng/pages/login/sign_up_page.dart';
import 'package:gaseng/pages/sharehouse/sharehouse_list_page.dart';
import 'package:gaseng/pages/sharehouse/sharehouse_page.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (_, child) {
        return GetMaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/login',
          getPages: [
            GetPage(name: '/login', page: () => LoginPage()),
            GetPage(name: '/login/sign-up', page: ()=> SignUpPage()),
            GetPage(name: '/login/find-account', page: ()=> FindAccountPage()),
            GetPage(name: '/login/find-account/email', page: ()=> FindEmailPage()),
            GetPage(name: '/login/find-account/email-result', page: ()=> FindEmailResultPage()),
            GetPage(name: '/login/find-account/password', page: ()=> FindPasswordPage()),
            GetPage(name: '/login/find-account/change-password', page: ()=> ChangePasswordPage()),
            GetPage(name: '/login/find-account/change-password-result', page: ()=> ChangePasswordResultPage()),
            GetPage(name: '/login/checklist', page: ()=> CheckListPage()),
            GetPage(name: '/main', page: ()=> MainTemplate()),
            GetPage(name: '/sharehouse', page: ()=> SharehouseListPage()),
            GetPage(name: '/sharehouse/detail', page: ()=> SharehousePage()),
            GetPage(name: '/sharehouse/notification', page: ()=> NotificationPage()),
            GetPage(name: '/mypage', page: ()=> MyPage()),
            GetPage(name: '/mypage/sharehouse', page: ()=> MySharehousePage()),
            GetPage(name: '/mypage/scrap', page: ()=> ScrapSharehousePage()),
            GetPage(name: '/mypage/checklist', page: ()=> CheckListModifyPage()),
            GetPage(name: '/chat', page: ()=> ChatListPage()),
            GetPage(name: '/chat/room', page: ()=> ChatRoomPage()),
            GetPage(name: '/kyc', page: ()=> KycCertificationPage()),
            GetPage(name: '/kyc/card-info', page: ()=> KycCardInfoPage()),
          ],
        );
      },
    );
  }
}

