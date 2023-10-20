import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaseng/constants/constant.dart';
import 'package:gaseng/widgets/gaseng_bottom_button.dart';
import 'package:gaseng/widgets/gaseng_general_button.dart';
import 'package:get/get.dart';

class KycCertificationPage extends StatelessWidget {
  const KycCertificationPage({Key? key}) : super(key: key);

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
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                height: 140.h,
                color: gray04,
                child: Center(
                  child: Text(
                    '스마트폰으로 3가지 스탭을 진행하여\n쉽게 귀하의 신원을 인증하세요',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(height: 20.0),
                    KycItem(
                      image: 'images/kyc1.png',
                      text1: 'Step1',
                      text2: '신분증 촬영하기',
                      text3: '운전면허증 사진의 앞부분을 촬영합니다.',
                    ),
                    SizedBox(height: 60.0),
                    KycItem(
                      image: 'images/kyc2.png',
                      text1: 'Step2',
                      text2: '얼굴 촬영하기',
                      text3: '전면 카메라로 귀하의 얼굴을 촬영합니다. 추가적으로 특정 행동을 요구합니다.',
                    ),
                    SizedBox(height: 60.0),
                    KycItem(
                      image: 'images/kyc3.png',
                      text1: 'Step3',
                      text2: '신분증 촬영하기',
                      text3: '귀하의 가장 최근 정보를 입력해주세요.',
                    ),
                  ],
                ),
              )
            ],
          ),
          GestureDetector(
            onTap: () => Get.toNamed("/kyc/card/info"),
            child: GasengBottomButton(
              text: '시작하기',
              color: primary,
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class KycItem extends StatelessWidget {
  KycItem({
    required this.image,
    required this.text1,
    required this.text2,
    required this.text3,
  });

  final image;
  final text1;
  final text2;
  final text3;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 30.0),
        Container(
          width: 60.0,
          height: 60.0,
          decoration:
              BoxDecoration(image: DecorationImage(image: AssetImage(image))),
        ),
        SizedBox(width: 40.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text1,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              Text(
                text2,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                text3,
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        )
      ],
    );
  }
}
