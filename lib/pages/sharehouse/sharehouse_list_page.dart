import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaseng/models/sharehouse/sharehouse_response.dart';
import 'package:gaseng/repositories/sharehouse_repository.dart';
import 'package:get/get.dart';

import '../../constants/constant.dart';
import '../../widgets/sharehouse_card.dart';

class SharehouseListPage extends StatefulWidget {
  @override
  State<SharehouseListPage> createState() => _SharehouseListPageState();
}

class _SharehouseListPageState extends State<SharehouseListPage> {
  SharehouseRepository sharehouseRepository = SharehouseRepository();
  List<SharehouseResponse>? sharehouses;
  Future? future;

  @override
  void initState() {
    future = getSharehouse();
    super.initState();
  }

  getSharehouse() async {
    sharehouses = await sharehouseRepository.getAll();
  }

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
      body: FutureBuilder(
        future: future,
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          if (sharehouses != null) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.separated(
                itemCount: sharehouses!.length,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 20); // 아래로 10 픽셀 간격을 줌
                },
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => Get.toNamed('/sharehouse/detail'),
                    child: SharehouseCard(
                      title: sharehouses![index].title,
                      poster: sharehouses![index].poster,
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
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
