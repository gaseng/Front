import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaseng/constants/constant.dart';
import 'package:get/get.dart';

class KycCardFilmPage extends StatelessWidget {
  const KycCardFilmPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: gray14,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                Container(
                  width: 350.w,
                  height: 200.w,
                  decoration: BoxDecoration(
                    color: gray08,
                    borderRadius: BorderRadius.all(Radius.circular(10.0))
                  ),
                ),
                SizedBox(height: 10.0),
                Text('신분증 촬영하기', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),),
                SizedBox(height: 8.0),
                Text('운전면허증 사진의 앞부분을 촬영합니다.\n 프레임에 맞게 신분증을 놓아주세요.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white),),
                Spacer(),
                GestureDetector(
                  onTap: () => Get.toNamed('kyc/card/result'),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(radius: 41.0, backgroundColor: gray10,),
                      CircleAvatar(radius: 40.0, backgroundColor: gray12, child: Icon(Icons.camera_alt_outlined, size: 30.0, color: gray10,),),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
              ],
            ),
          )
        ],
      ),
    );
  }
}
