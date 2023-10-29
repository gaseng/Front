import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaseng/models/sharehouse/sharehouse_delete_request.dart';
import 'package:gaseng/repositories/sharehouse_repository.dart';

import '../../constants/constant.dart';
import 'package:get/get.dart';

import '../../models/sharehouse/sharehouse_response.dart';

class MySharehousePage extends StatefulWidget {
  const MySharehousePage({Key? key}) : super(key: key);

  @override
  State<MySharehousePage> createState() => _MySharehousePageState();
}

class _MySharehousePageState extends State<MySharehousePage> {
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

  goEdit(int id) {
    Get.toNamed('/sharehouse/edit', arguments: id);
  }

  deleteSharehouse(int id) async {
    await sharehouseRepository.delete(SharehouseDeleteRequest(id: id));
    sharehouses = await sharehouseRepository.getAll();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '내가 쓴 글',
          style: TextStyle(color: Colors.black, fontSize: 16.0),
        ),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (sharehouses == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: sharehouses!.map((sharehouse) {
                  return SharehouseCardSmall(
                    id: sharehouse.id,
                    title: sharehouse.title,
                    description: sharehouse.description,
                    address: sharehouse.address,
                    image: sharehouse.poster,
                    goMethod: goEdit,
                    deleteMethod: deleteSharehouse,
                  );
                }).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}

class SharehouseCardSmall extends StatelessWidget {
  SharehouseCardSmall({
    required this.id,
    required this.title,
    required this.description,
    required this.address,
    required this.image,
    required this.deleteMethod,
    required this.goMethod,
  });

  final id;
  final title;
  final description;
  final address;
  final image;
  final deleteMethod;
  final goMethod;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.h,
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          boxShadow: cardShadow),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 140.h,
              decoration: BoxDecoration(
                color: gray04,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0)),
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.cover,
                  ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      PopupMenuButton(onSelected: (String choice) {
                        if (choice == '수정') {
                          goMethod(id);
                        } else if (choice == '삭제') {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('정말 삭제하시겠습니까?'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('취소'),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                                TextButton(
                                  child: Text('확인'),
                                  onPressed: () async {
                                    await deleteMethod(id);
                                    Get.back();
                                  },
                                ),
                              ],
                            );
                          });
                        }
                      }, itemBuilder: (BuildContext ctx) {
                        return [
                          _menuItem(text: '수정'),
                          _menuItem(text: '삭제'),
                        ];
                      }),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Text(address, style: TextStyle(fontSize: 12.0)),
                  SizedBox(height: 8.0),
                  Expanded(
                    child: Text(
                      description,
                      style: TextStyle(fontSize: 12.0),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  PopupMenuItem<String> _menuItem(
      {required String text, Color color = Colors.black}) {
    return PopupMenuItem<String>(
      enabled: true,
      onTap: () {},
      value: text,
      height: 40,
      child: Text(
        text,
        style: TextStyle(color: color),
      ),
    );
  }
}
