import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/constant.dart';

class SharehouseCard extends StatelessWidget {
  SharehouseCard({required this.title, required this.poster});

  final title;
  final poster;

  Widget renderImage() {
    if (poster == null) {
      return const SizedBox();
    } else {
      return Container(
        height: 160.h,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(poster)
            )
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: cardShadow,
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: gray06,
                  radius: 20.0,
                ),
                SizedBox(width: 12.0),
                Text(
                  '눈물섞인 그녀',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 12.0),
                Text(
                  '3분전',
                  style: TextStyle(fontSize: 12.0, color: gray08),
                ),
              ],
            ),
          ),
          renderImage(),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  '경기도 성남시',
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 8.0),
                Text(
                  '소음이 없는 곳이 장점입니다. 다른 사람들의 쉐어하우스와는 다르게 커피머신을 제공하여 마음껏 커피를 드셔도 되는 공간입니다. 소음이 없기 때문에 걷거나 돌아다니실 때 조용히 해주셔야 합니다.',
                  style: TextStyle(fontSize: 12.0),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
