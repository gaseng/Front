import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/constant.dart';
import '../../widgets/gaseng_general_button.dart';
import '../../widgets/gaseng_text_field.dart';

class KycSubmitPage extends StatefulWidget {
  @override
  State<KycSubmitPage> createState() => _KycSubmitPageState();
}

class _KycSubmitPageState extends State<KycSubmitPage> {
  late List<String> list;
  late String dropdownValue;

  @override
  void initState() {
    list = ['학생', '직장인', '무직'];
    dropdownValue = list.first;
    super.initState();
  }

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '이름',
              style: TextStyle(
                  fontSize: 12.0, fontWeight: FontWeight.bold, color: gray08),
            ),
            SizedBox(height: 12.0),
            GasengTextField(labelText: '이름'),
            SizedBox(height: 12),
            Text(
              '생일',
              style: TextStyle(
                  fontSize: 12.0, fontWeight: FontWeight.bold, color: gray08),
            ),
            SizedBox(height: 12.0),
            GasengTextField(labelText: '생일'),
            SizedBox(height: 12),
            Row(
              children: [
                Text(
                  '주소지',
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: gray08),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  child: Text(
                    '우편번호 검색',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            SizedBox(height: 12.0),
            GasengTextField(labelText: '주소지'),
            SizedBox(height: 12.0),
            GasengTextField(labelText: '세부 주소'),
            SizedBox(height: 12.0),
            Text(
              '직업',
              style: TextStyle(
                  fontSize: 12.0, fontWeight: FontWeight.bold, color: gray08),
            ),
            SizedBox(height: 12.0),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: DropdownButton(
                value: dropdownValue,
                items: list.map((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    dropdownValue = value!;
                  });
                },
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () => Get.offAllNamed('/main'),
              child: GasengGeneralButton(
                text: 'KYC 제출',
                color: primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
