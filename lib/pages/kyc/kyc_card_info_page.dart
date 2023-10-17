import 'package:flutter/material.dart';
import 'package:gaseng/widgets/gaseng_general_button.dart';

import '../../constants/constant.dart';

class KycCardInfoPage extends StatelessWidget {
  const KycCardInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '신분증 촬영하기',
          style: TextStyle(color: Colors.black, fontSize: 16.0),
        ),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.0),
            Text(
              '신분증 촬영하기',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              '운전면허증 사진의 앞부분을 촬영합니다.\n프레임에 맞게 신분증을 놓아주세요.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 30.0),
            Container(
              width: 200.0,
              height: 140.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/kyc-big-1.png')
                )
              ),
            ),
            SizedBox(height: 30.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('힌트', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),),
                SizedBox(height: 8.0),
                Text('- 반사에 조심해주시고, 신분증이 잘 나오는 곳에서 촬영해주세요.', style: TextStyle(fontSize: 12.0, color: gray10),),
                SizedBox(height: 8.0),
                Text('- 신분증 아이디가 다른 것에 의해 덮여지지 않게 촬영해주세요.', style: TextStyle(fontSize: 12.0, color: gray10),),
                SizedBox(height: 8.0),
                Text('- 하얀 배경 위에 위치시켜 귀하의 신분증이 쉽게 보이도록 놓아주세요.', style: TextStyle(fontSize: 12.0, color: gray10),),
              ],
            ),
            Spacer(),
            GasengGeneralButton(text: '시작하기', color: primary, textColor: Colors.white,)
          ],
        ),
      ),
    );
  }
}
