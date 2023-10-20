import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/constant.dart';
import 'package:get/get.dart';

class MySharehousePage extends StatelessWidget {
  const MySharehousePage({Key? key}) : super(key: key);

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: cardShadow
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: gray04,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0)),
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
                              Text('넓지만 아늑한 수내역', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
                              Spacer(),
                              PopupMenuButton(
                                onSelected: (String choice) {
                                  if (choice == '수정') {
                                    Get.toNamed('/sharehouse/edit');
                                  }
                                },
                                  itemBuilder: (BuildContext ctx) {
                                    return [
                                      _menuItem(text: '수정'),
                                      _menuItem(text: '삭제'),
                                    ];
                                  }
                              ),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Text('경기도 성남시', style: TextStyle(fontSize: 12.0)),
                          SizedBox(height: 8.0),
                          Text('일단 둘러보셔도 됩니다. 먼저 연락주신다음 찬찬히 둘러보세요.', style: TextStyle(fontSize: 12.0), maxLines: 2,),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  PopupMenuItem<String> _menuItem({required String text, Color color = Colors.black}) {
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
