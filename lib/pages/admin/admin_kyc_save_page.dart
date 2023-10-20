import 'package:flutter/material.dart';
import 'package:gaseng/widgets/gaseng_general_button.dart';
import 'package:gaseng/widgets/gaseng_text_field.dart';

import '../../constants/constant.dart';

class AdminKycSavePage extends StatelessWidget {
  const AdminKycSavePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'KYC 요청 저장',
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
            Text('KYC 결정',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: gray10,
                    fontSize: 12.0)),
            SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                    child: GasengGeneralButton(
                  text: '반려',
                  color: Colors.white,
                  textColor: Colors.black,
                )),
                SizedBox(width: 12.0),
                Expanded(
                    child: GasengGeneralButton(
                  text: '거절',
                  color: Colors.white,
                  textColor: Colors.black,
                )),
                SizedBox(width: 12.0),
                Expanded(
                    child: GasengGeneralButton(
                  text: '승인',
                  color: Colors.white,
                  textColor: Colors.black,
                )),
              ],
            ),
            SizedBox(height: 30.0),
            Text('사유',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: gray10,
                    fontSize: 12.0)),
            SizedBox(height: 8.0),
            GasengTextField(labelText: '사유',),
            Spacer(),
            GasengGeneralButton(text: '결정', color: primary)
          ],
        ),
      ),
    );
  }
}
