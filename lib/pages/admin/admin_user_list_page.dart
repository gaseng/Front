import 'dart:async';

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
  final ScrollController _scrollController = ScrollController();
  final double triggerThreshold = 100.0;
  final Duration debounceDuration = Duration(milliseconds: 500);

  bool isLoading = false;
  Timer? _debounce;

  @override
  void initState() {
    future = getMemberList(null);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - triggerThreshold) {
        _handleScrollEnd();
      }
    });
    super.initState();
  }

  getMemberList(int? index) async {
    await adminRepository.getMemberList(index, memberList);
    setState(() {

    });
  }

  void _handleScrollEnd() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(debounceDuration, () {
      if (!isLoading) {
        setState(() {
          isLoading = true;
        });
        _loadMoreData();
      }
    });
  }

  void _loadMoreData() async {
    print("load");
    await getMemberList(memberList.last.memId);
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
            controller: _scrollController,
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
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 40.0),
          child: Text(name, style: TextStyle(fontSize: 14.0)),
        ),
        Divider(),
      ],
    );
  }
}
