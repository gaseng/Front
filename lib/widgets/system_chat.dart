import 'package:flutter/material.dart';

import '../constants/constant.dart';

class SystemChat extends StatelessWidget {
  SystemChat({required this.mode});

  final int mode;

  buildBrain(int mode) {
    if (mode == 1) {
      return buildMode1();
    } else if (mode == 2) {
      return buildMode2();
    } else if (mode == 3) {
      return buildMode3();
    } else {
      return buildMode4();
    }
  }

  Widget buildMode1() {
    return Column(
      children: [
        Text(
          '상대방이 KYC를 요청했습니다.\n상대를 신뢰할 수 있을 때만 수락을 눌러주세요.',
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8.0),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 6.0),
                decoration: BoxDecoration(
                  color: gray06,
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
                child: Center(child: Text('거절')),
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 6.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
                child: Center(child: Text('수락')),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildMode2() {
    return Text('상대방에게 KYC를 요청했습니다.\n상대방이 요청에 응하면 KYC 정보가 나타납니다.', textAlign: TextAlign.center,);
  }

  Widget buildMode3() {
    return Column(
      children: [
        Text('KYC를 수락했습니다.', textAlign: TextAlign.center,),
        SizedBox(height: 8.0),
        Text('이름 : 홍길동'),
        Text('전화번호 : 010-1234-5678'),
        Text('성별 : 남자'),
      ],
    );
  }

  Widget buildMode4() {
    return Text('KYC를 거절했습니다.', textAlign: TextAlign.center,);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            margin: EdgeInsets.symmetric(vertical: 40.0),
            decoration: BoxDecoration(
                color: gray04,
                borderRadius: BorderRadius.all(Radius.circular(4.0))),
            child: buildBrain(mode),
          ),
        ),
      ],
    );
  }
}
