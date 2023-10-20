import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaseng/widgets/gaseng_bottom_button.dart';
import 'package:gaseng/widgets/gaseng_general_button.dart';
import 'package:get/get.dart';

import '../../constants/constant.dart';

class KycCardResultPage extends StatelessWidget {
  const KycCardResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'KYC 인증',
          style: TextStyle(color: Colors.black, fontSize: 16.0),
        ),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.0),
            Center(
              child: Container(
                width: 350.w,
                height: 200.w,
                decoration: BoxDecoration(
                    color: gray08,
                    borderRadius: BorderRadius.all(Radius.circular(10.0))
                ),
              ),
            ),
            SizedBox(height: 50.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '다시 한번 확인해주세요',
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  '- 귀하의 신분증 아이디가 보이시나요?',
                  style: TextStyle(fontSize: 12.0, color: gray10),
                ),
                SizedBox(height: 8.0),
                Text(
                  '- 이미지의 텍스트를 깔끔하게 볼 수 있나요?',
                  style: TextStyle(fontSize: 12.0, color: gray10),
                ),
                SizedBox(height: 8.0),
                Text(
                  '- 반사된 빛이나 손가락으로 신분증을 가리지 않았나요?',
                  style: TextStyle(fontSize: 12.0, color: gray10),
                ),
              ],
            ),
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Get.toNamed('/kyc/card/info'),
                    child: GasengGeneralButton(
                      text: '다시하기',
                      color: gray10,
                      textColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 12.0),
                Expanded(
                  child: GestureDetector(
                    onTap: () => Get.toNamed('/kyc/face/info'),
                    child: GasengGeneralButton(
                      text: '다음',
                      color: primary,
                      textColor: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
