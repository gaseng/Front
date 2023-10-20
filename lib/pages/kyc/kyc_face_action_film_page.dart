import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaseng/constants/constant.dart';
import 'package:get/get.dart';

class KycFaceActionFilmPage extends StatelessWidget {
  const KycFaceActionFilmPage({Key? key}) : super(key: key);

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
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(radius: 50.0, backgroundColor: gray08),
                      Container(
                        width: 150.w,
                        height: 70.w,
                        decoration: BoxDecoration(
                          color: gray08,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(100.0), topRight: Radius.circular(100.0)),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50.0),
                Text('특정 얼굴 촬영하기', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),),
                SizedBox(height: 8.0),
                Text('전면 카메라로 귀하의 얼굴을 촬영합니다.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white),),
                Spacer(),
                GestureDetector(
                  onTap: () => Get.toNamed('/kyc/submit'),
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
