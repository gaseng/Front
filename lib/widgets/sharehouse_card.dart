import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/constant.dart';

class SharehouseCard extends StatelessWidget {
  SharehouseCard({
    required this.name,
    required this.date,
    required this.title,
    required this.poster,
    required this.address,
    required this.description,
  });

  final name;
  final date;
  final title;
  final poster;
  final address;
  final description;

  Widget renderImage() {
    if (poster == null) {
      return const SizedBox();
    } else {
      return Container(
        height: 160.h,
        decoration:
            BoxDecoration(image: DecorationImage(image: NetworkImage(poster), fit: BoxFit.cover)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: cardShadow,
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 12.0),
                Text(
                  date,
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
                  address,
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 8.0),
                Text(
                  description,
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
