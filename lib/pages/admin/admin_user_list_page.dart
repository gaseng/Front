import 'package:flutter/material.dart';

import '../../constants/constant.dart';
import 'package:get/get.dart';

class AdminUserListPage extends StatelessWidget {
  const AdminUserListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '사용자 조회',
          style: TextStyle(color: Colors.black, fontSize: 16.0),
        ),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          GestureDetector(
            onTap: () => Get.toNamed('/admin/user/detail'),
            child: UserListTile(name: '김민수'),
          ),
          UserListTile(name: '이민경'),
          UserListTile(name: '강감찬'),
          UserListTile(name: '이소진'),
        ],
      ),
    );
  }
}

class UserListTile extends StatelessWidget {
  UserListTile({required this.name});

  final name;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          color: Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
          child: Text(name, style: TextStyle(fontSize: 14.0)),
        ),
        Divider(),
      ],
    );
  }
}
