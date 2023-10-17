import 'package:flutter/material.dart';

import '../../constants/constant.dart';
import '../../widgets/gaseng_general_button.dart';

class CheckListPage extends StatefulWidget {

  @override
  State<CheckListPage> createState() => _CheckListPageState();
}

class _CheckListPageState extends State<CheckListPage> {
  TimeOfDay initialTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '체크리스트 작성',
          style: TextStyle(color: Colors.black, fontSize: 16.0),
        ),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '흡연',
              style: TextStyle(color: gray08),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: GasengGeneralButton(
                    text: '비흡연자',
                    color: primary,
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(width: 12.0),
                Expanded(
                    child:
                        GasengGeneralButton(text: '흡연자', color: Colors.white)),
              ],
            ),
            SizedBox(height: 34),
            Text(
              '잠버릇',
              style: TextStyle(color: gray08),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: GasengGeneralButton(
                    text: '코골이 없음',
                    color: primary,
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(width: 12.0),
                Expanded(
                  child: GasengGeneralButton(
                    text: '코골이 약간',
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 12.0),
                Expanded(
                  child: GasengGeneralButton(
                    text: '코골이 심함',
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 34),
            Text(
              '소등 시간',
              style: TextStyle(color: gray08),
            ),
            SizedBox(height: 12),
            GestureDetector(
              onTap: () async {
                final TimeOfDay? timeOfDay = await showTimePicker(
                  context: context,
                  initialTime: initialTime
                );
                if (timeOfDay != null) {
                  setState(() {
                    initialTime = timeOfDay;
                  });
                }
              },
              child: Container(
                child: Text('${initialTime.hour}:${initialTime.minute}', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400)),
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: gray04,
                  borderRadius: BorderRadius.all(Radius.circular(8.0))
                ),
              ),
            ),
            SizedBox(height: 34),
            Text(
              '생활 습관',
              style: TextStyle(color: gray08),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: GasengGeneralButton(
                    text: '활동적',
                    color: primary,
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(width: 12.0),
                Expanded(
                  child: GasengGeneralButton(
                    text: '소극적',
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Spacer(),
            GasengGeneralButton(text: '확인', color: primary, textColor: Colors.white,)
          ],
        ),
      ),
    );
  }
}
