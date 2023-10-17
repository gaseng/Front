import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaseng/constants/constant.dart';

import '../../widgets/hash_tag.dart';

class SharehousePage extends StatelessWidget {
  const SharehousePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '쉐어하우스',
          style: TextStyle(color: Colors.black, fontSize: 16.0),
        ),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: 220.h,
                  color: gray04,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 3.0,
                        backgroundColor: gray08,
                      ),
                      SizedBox(width: 4.0),
                      CircleAvatar(
                        radius: 3.0,
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(width: 4.0),
                      CircleAvatar(
                        radius: 3.0,
                        backgroundColor: Colors.white,
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 24.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '모두가 조용한 이 곳',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    '경기도 성남시',
                    style:
                        TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    '소음이 없는 곳이 장점입니다. 다른 사람들의 쉐어하우스와는 다르게 커피머신을 제공하여 마음껏 커피를 드셔도 되는 공간입니다. 소음이 없기 때문에 걷거나 돌아다니실 때 조용히 해주셔야 합니다.',
                    style: TextStyle(fontSize: 12.0),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '입주자',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: gray12,
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 16.0,
                        backgroundColor: gray06,
                      ),
                      SizedBox(width: 8.0),
                      Text('백만송이 장미',
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.bold))
                    ],
                  ),
                  SizedBox(height: 12.0),
                  Wrap(
                    children: [
                      HashTag(text: '비흡연자'),
                      HashTag(text: '코골이 약간'),
                      HashTag(text: '자는 시간 : 11 AM'),
                      HashTag(text: '소극적'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '지도',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: gray12),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    '경기도 성남시 부근',
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: gray12),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            Container(
              width: double.infinity,
              height: 200.h,
              color: gray04,
            )
          ],
        ),
      ),
    );
  }
}
