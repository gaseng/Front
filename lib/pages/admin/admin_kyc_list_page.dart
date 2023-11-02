import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaseng/auth/SessionManager.dart';
import 'package:gaseng/pages/admin/admin_kyc_detail_page.dart';
import 'package:gaseng/repositories/login_repository.dart';

import '../../constants/constant.dart';
import 'package:get/get.dart';

class AdminKycListPage extends StatefulWidget {
  const AdminKycListPage({Key? key}) : super(key: key);

  @override
  State<AdminKycListPage> createState() => _AdminKycListPageState();
}

class _AdminKycListPageState extends State<AdminKycListPage> {

  LoginRepository loginRepository = LoginRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'KYC 목록 조회',
            style: TextStyle(color: Colors.black, fontSize: 16.0),
          ),
          actions: [
            GestureDetector(
              onTap: () async {
                String? memId = await SessionManager.getMemId();
                print("memId : $memId");
                if (memId != null) {
                  loginRepository.logout(int.parse(memId));
                  await SessionManager.clearTokens();
                  Get.offAllNamed('/login');
                }
              },
              child: Icon(
                Icons.logout,
                color: Colors.black,
              ),
            ),
            SizedBox(width: 16.0),
          ],
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            GestureDetector(
              onTap: () => Get.toNamed('/admin/kyc/detail'),
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  border: Border.all(color: gray06),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('김민수의 KYC',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8.0),
                    Text('2023. 10. 06',
                        style: TextStyle(fontSize: 12.0, color: gray08)),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
