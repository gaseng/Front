import 'package:flutter/material.dart';
import 'package:gaseng/widgets/gaseng_bottom_button.dart';
import 'package:gaseng/widgets/gaseng_general_button.dart';
import 'package:gaseng/widgets/gaseng_text_field.dart';

import '../../constants/constant.dart';

class AddSharehousePage extends StatelessWidget {
  const AddSharehousePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '쉐어하우스 글 등록',
          style: TextStyle(color: Colors.black, fontSize: 16.0),
        ),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('쉐어하우스', style: TextStyle(fontWeight: FontWeight.bold, color: gray10, fontSize: 12.0)),
                  SizedBox(height: 8.0),
                  GasengTextField(labelText: '제목'),
                  SizedBox(height: 12.0),
                  GasengTextField(labelText: '내용'),
                  SizedBox(height: 12.0),
                  Row(
                    children: [
                      Spacer(),
                      Text('사진 첨부', style: TextStyle(color: Colors.indigo, fontSize: 12, fontWeight: FontWeight.bold),),
                    ],
                  ),
                  SizedBox(height: 30.0),
                  Text('주소', style: TextStyle(fontWeight: FontWeight.bold, color: gray10, fontSize: 12.0)),
                  SizedBox(height: 8.0),
                  GasengTextField(labelText: '주소'),
                  SizedBox(height: 12.0),
                  Row(
                    children: [
                      Expanded(child: GasengTextField(labelText: '세부주소')),
                      SizedBox(width: 12.0),
                      GasengGeneralButton(text: '우편번호 검색', color: primary),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Spacer(),
              GasengBottomButton(text: '등록', color: primary),
            ],
          )
        ],
      ),
    );
  }
}
