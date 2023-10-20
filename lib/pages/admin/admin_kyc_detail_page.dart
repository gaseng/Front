import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaseng/widgets/gaseng_general_button.dart';

import '../../constants/constant.dart';
import 'package:get/get.dart';

class AdminKycDetailPage extends StatelessWidget {
  const AdminKycDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'KYC 요청 조회',
          style: TextStyle(color: Colors.black, fontSize: 16.0),
        ),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '김동헌의 KYC',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Container(
              height: 150.h,
              color: gray06,
            ),
            SizedBox(height: 40.0),
            KycRequestItem(title: '이름', message: '김동헌'),
            SizedBox(height: 12.0),
            KycRequestItem(title: '생일', message: '1998. 03. 16'),
            SizedBox(height: 12.0),
            KycRequestItem(title: '주소지', message: '경기도 성남시 수정구'),
            SizedBox(height: 12.0),
            KycRequestItem(title: '직업', message: '무직'),
            Spacer(),
            GestureDetector(
              onTap: () => Get.toNamed('/admin/kyc/save'),
              child: GasengGeneralButton(text: '확인', color: primary),
            ),
          ],
        ),
      ),
    );
  }
}

class KycRequestItem extends StatelessWidget {
  KycRequestItem({required this.title, required this.message});

  final title;
  final message;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: gray10, fontSize: 12.0)),
        SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            border: Border.all(color: gray06),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Text(message),
        )
      ],
    );
  }
}
