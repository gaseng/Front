import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/constant.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            '알림',
            style: TextStyle(color: Colors.black, fontSize: 16.0),
          ),
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            decoration: BoxDecoration(border: Border.all(color: gray04)),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20.0,
                ),
                SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'KYC가 승인되었습니다.',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12.0),
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            '3분 전',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                                color: gray08),
                          )
                        ],
                      ),
                      Text(
                        '관리자에 의해 KYC가 승인되었습니다. KYC가 저장된 주소는 0xc7338b56a38c356709faa1230c1957b10c04f1882dd입니다.',
                        style: TextStyle(color: gray08, fontSize: 12.0),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            decoration: BoxDecoration(border: Border.all(color: gray04)),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20.0,
                ),
                SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'KYC가 승인되었습니다.',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12.0),
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            '3분 전',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                              color: gray08,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '관리자에 의해 KYC가 승인되었습니다. KYC가 저장된 주소는 0xc7338b56a38c356709faa1230c1957b10c04f1882dd입니다.',
                        style: TextStyle(color: gray08, fontSize: 12.0),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
