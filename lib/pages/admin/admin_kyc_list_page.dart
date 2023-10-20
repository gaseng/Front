import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaseng/pages/admin/admin_kyc_detail_page.dart';

import '../../constants/constant.dart';
import 'package:get/get.dart';

class AdminKycListPage extends StatelessWidget {
  const AdminKycListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'KYC 리스트 조회',
          style: TextStyle(color: Colors.black, fontSize: 16.0),
        ),
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
                  Text('김민수의 KYC', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8.0),
                  Text('2023. 10. 06', style: TextStyle(fontSize: 12.0, color: gray08)),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}
