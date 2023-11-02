import 'package:flutter/material.dart';
import 'package:gaseng/widgets/gaseng_general_button.dart';

import '../../constants/constant.dart';
import 'package:get/get.dart';

class KycFaceActionInfoPage extends StatelessWidget {
  const KycFaceActionInfoPage({Key? key}) : super(key: key);

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
          margin: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.0),
              Text(
                '특정 얼굴 촬영하기',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                '전면 카메라로 귀하의 얼굴을 촬영합니다.\n 특정 행동이 제시됩니다.',
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
                        image: AssetImage('images/kyc-big-3.png'))),
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
                    '- 전면 카메라를 사용합니다.',
                    style: TextStyle(fontSize: 12.0, color: gray10),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    '- 머리카락으로 얼굴 전체가 덮여지면 안 되며, 프레임에 맞게 얼굴을 일치시켜 주세요.',
                    style: TextStyle(fontSize: 12.0, color: gray10),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    '- 진행할 수 없다면 모자, 안경, 또는 다른 액세서리를 제거해주세요.',
                    style: TextStyle(fontSize: 12.0, color: gray10),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    '- 사진에는 귀하를 제외한 다른 사람이 있어서는 안 됩니다.',
                    style: TextStyle(fontSize: 12.0, color: gray10),
                  ),
                ],
              ),
              Spacer(),
              GestureDetector(
                onTap: () => Get.toNamed('/kyc/face-action/film'),
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
