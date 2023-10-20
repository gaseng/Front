import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/constant.dart';
import '../../widgets/sharehouse_card.dart';

class SharehouseListPage extends StatelessWidget {
  const SharehouseListPage({Key? key}) : super(key: key);

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
          actions: [
            GestureDetector(
              onTap: () => Get.toNamed('/sharehouse/notification'),
              child: Icon(
                Icons.notifications_outlined,
                color: Colors.black,
              ),
            ),
            SizedBox(width: 16.0),
          ]),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => Get.toNamed('/sharehouse/detail'),
              child: SharehouseCard(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('sharehouse/add'),
        child: Icon(
          Icons.add,
          size: 30.0,
          color: Colors.white,
        ),
        backgroundColor: primary,
      ),
    );
  }
}
