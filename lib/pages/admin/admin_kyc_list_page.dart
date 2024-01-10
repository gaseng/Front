import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaseng/auth/session_manager.dart';
import 'package:gaseng/pages/admin/admin_kyc_detail_page.dart';
import 'package:gaseng/repositories/login_repository.dart';
import 'package:gaseng/utils/formatter.dart';

import '../../constants/constant.dart';
import 'package:get/get.dart';

import '../../models/kyc/kyc_require_summary_response.dart';
import '../../repositories/kyc_repository.dart';

class AdminKycListPage extends StatefulWidget {
  const AdminKycListPage({Key? key}) : super(key: key);

  @override
  State<AdminKycListPage> createState() => _AdminKycListPageState();
}

class _AdminKycListPageState extends State<AdminKycListPage> {
  KycRepository kycRepository = KycRepository();
  late Future future;
  late List<KycRequireSummaryResponse> responses;
  LoginRepository loginRepository = LoginRepository();

  @override
  void initState() {
    responses = [];
    future = getAll();
    super.initState();
  }

  Future<void> getAll() async {
    await kycRepository.getAll(responses);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'KYC 목록 조회',
          style: TextStyle(color: Colors.black, fontSize: 16.0),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              String? memId = await SessionManager.getMemId();
              if (memId != null) {
                loginRepository.logout(int.parse(memId));
                await SessionManager.clearTokens();
                Get.offAllNamed('/login');
              }
            },
            child: Icon(
              Icons.logout,
              color: Colors.black,
            ),
          ),
          SizedBox(width: 16.0),
        ],
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (responses.isEmpty) {
            return Center(child: Text('요청이 없습니다.'),);
          } else {
            return ListView(
                padding: EdgeInsets.all(16.0),
                children: responses.map((kyc) {
                  return GestureDetector(
                      onTap: () => Get.toNamed('/admin/kyc/detail', arguments: kyc.id),
                      child: KycListCard(name: kyc.name, date: Formatter.customFormatter(kyc.createdAt),)
                  );
                }).toList()
            );
          }
        },
      ),
    );
  }
}

class KycListCard extends StatelessWidget {
  KycListCard({required this.name, required this.date});
  final name;
  final date;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        border: Border.all(color: gray06),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$name의 KYC',
              style: TextStyle(
                  fontSize: 16.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text(date,
              style: TextStyle(fontSize: 12.0, color: gray08)),
        ],
      ),
    );
  }
}
