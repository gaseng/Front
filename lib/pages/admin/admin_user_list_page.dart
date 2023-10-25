import 'package:flutter/material.dart';
import 'package:gaseng/repositories/admin_repository.dart';

import '../../constants/constant.dart';
import 'package:get/get.dart';

import '../../models/user/member_list_summary.dart';

class AdminUserListPage extends StatefulWidget {
  const AdminUserListPage({Key? key}) : super(key: key);

  @override
  State<AdminUserListPage> createState() => _AdminUserListPageState();
}

class _AdminUserListPageState extends State<AdminUserListPage> {
  AdminRepository adminRepository = AdminRepository();
  Future? future;
  List<MemberListSummary> memberList = [];

  @override
  void initState() {
    future = getMemberList();
    super.initState();
  }

  getMemberList() async {
    memberList = await adminRepository.getMemberList();
  }

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
      body: FutureBuilder(
        future: future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return ListView(
            children: memberList.map((member) {
              return GestureDetector(
                onTap: () => Get.toNamed('/admin/user/detail', arguments: member.memId),
                child: UserListTile(name: member.memName),
              );
            }).toList(),
          );
        },
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
