import 'package:flutter/material.dart';
import 'package:gaseng/widgets/gaseng_bottom_button.dart';
import 'package:gaseng/widgets/gaseng_general_button.dart';
import 'package:get/get.dart';

import '../../constants/constant.dart';

class KycCardInfoPage extends StatelessWidget {
  const KycCardInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'KYC 인증',
            style: TextStyle(color: Colors.black, fontSize: 16.0),
          ),
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('여기서 종료하시겠습니까?'),
                    content: Text('여기서 종료하시면 모든 과정을 처음부터 진행해야 합니다.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text('취소'),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.offAllNamed('/main');
                        },
                        child: Text('확인'),
                      ),
                    ],
                  );
                },
              );
            },
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
                        image: AssetImage('images/kyc-big-1.png'))),
              ),
              SizedBox(height: 30.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '힌트',
                    style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    '- 반사에 조심해주시고, 신분증이 잘 나오는 곳에서 촬영해주세요.',
                    style: TextStyle(fontSize: 12.0, color: gray10),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    '- 신분증 아이디가 다른 것에 의해 덮여지지 않게 촬영해주세요.',
                    style: TextStyle(fontSize: 12.0, color: gray10),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    '- 하얀 배경 위에 위치시켜 귀하의 신분증이 쉽게 보이도록 놓아주세요.',
                    style: TextStyle(fontSize: 12.0, color: gray10),
                  ),
                ],
              ),
              Spacer(),
              GestureDetector(
                onTap: () => Get.toNamed('/kyc/card/film'),
                child: GasengGeneralButton(
                  text: '시작하기',
                  color: primary,
                  textColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
