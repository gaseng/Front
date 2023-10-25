import 'package:flutter/material.dart';
import 'package:gaseng/models/user/account_response.dart';
import 'package:gaseng/repositories/admin_repository.dart';
import 'package:gaseng/widgets/gaseng_bottom_button.dart';
import 'package:gaseng/widgets/gaseng_general_button.dart';
import 'package:get/get.dart';

import '../../constants/constant.dart';

class AdminUserDetailPage extends StatefulWidget {
  const AdminUserDetailPage({Key? key}) : super(key: key);

  @override
  State<AdminUserDetailPage> createState() => _AdminUserDetailPageState();
}

class _AdminUserDetailPageState extends State<AdminUserDetailPage> {
  AdminRepository adminRepository = AdminRepository();
  AccountResponse? account;
  int? memId;
  Future? future;

  @override
  void initState() {
    memId = Get.arguments;
    if (memId != null) {
      future = getAccount(memId!);
    }
    super.initState();
  }

  getAccount(int memId) async {
    account = await adminRepository.getAccount(memId);
  }

  updateAccount() async {
    account = await adminRepository.getAccount(account!.id);
    setState(() {});
  }

  toNormal() async {
    await adminRepository.toNormal(account!.id);
    Get.back();
  }

  toReject() async {
    await adminRepository.toReject(account!.id);
    Get.back();
  }

  showMyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('상태 변경'),
          content: Row(
            children: <Widget>[
              if (account!.status != '노멀')
                TextButton(
                  onPressed: toNormal,
                  child: Text('노멀'),
                ),
              if (account!.status != '거절')
                TextButton(
                  onPressed: toReject,
                  child: Text('거절'),
                ),
            ],
          ),
        );
      },
    ).then((value) {
      updateAccount();
    });
  }

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
      body: FutureBuilder(
        future: future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (account == null || memId == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('이름 : ${account!.name}',
                      style: TextStyle(fontSize: 16.0)),
                  SizedBox(height: 12.0),
                  Text('이메일 : ${account!.email}',
                      style: TextStyle(fontSize: 16.0)),
                  SizedBox(height: 12.0),
                  Text('닉네임 : ${account!.nickname}',
                      style: TextStyle(fontSize: 16.0)),
                  SizedBox(height: 12.0),
                  Text('전화번호 : ${account!.phone}',
                      style: TextStyle(fontSize: 16.0)),
                  SizedBox(height: 12.0),
                  Text('생성일 : ${account!.createdDate}',
                      style: TextStyle(fontSize: 16.0)),
                  SizedBox(height: 12.0),
                  Text('성별 : ${account!.sex}',
                      style: TextStyle(fontSize: 16.0)),
                  SizedBox(height: 12.0),
                  Text('상태 : ${account!.status}',
                      style: TextStyle(fontSize: 16.0)),
                  Spacer(),
                  GestureDetector(
                    onTap: () => showMyDialog(context),
                    child: GasengGeneralButton(
                      text: '상태 변경',
                      color: primary,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
