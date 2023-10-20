import 'package:flutter/material.dart';

class AdminUserDetailPage extends StatelessWidget {
  const AdminUserDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '사용자',
          style: TextStyle(color: Colors.black, fontSize: 16.0),
        ),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('이름 : 김민수', style: TextStyle(fontSize: 16.0)),
            SizedBox(height: 12.0),
            Text('이메일 : test@naver.com', style: TextStyle(fontSize: 16.0)),
            SizedBox(height: 12.0),
            Text('닉네임 : 앉어', style: TextStyle(fontSize: 16.0)),
            SizedBox(height: 12.0),
            Text('전화번호 : 010-1234-5678', style: TextStyle(fontSize: 16.0)),
            SizedBox(height: 12.0),
            Text('생성일 : 2022. 01. 01', style: TextStyle(fontSize: 16.0)),
            SizedBox(height: 12.0),
            Text('성별 : 남자', style: TextStyle(fontSize: 16.0)),
            SizedBox(height: 12.0),
            Text('상태 : 0', style: TextStyle(fontSize: 16.0)),
          ],
        ),
      ),
    );
  }
}
