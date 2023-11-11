import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaseng/repositories/kyc_repository.dart';

import '../../constants/constant.dart';
import '../../models/kyc/kyc_notification_response.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  KycRepository kycRepository = KycRepository();
  late Future future;
  List<KycNotificationResponse> response = [];

  @override
  void initState() {
    future = getNotification();
    super.initState();
  }

  Future<void> getNotification() async {
    response = await kycRepository.getNotification();
  }

  String getTitle(String notice) {
    if (notice == 'DENIAL') {
      return 'KYC 반려됨';
    } else if (notice == 'REJECT') {
      return 'KYC 거절됨';
    } else if (notice == 'APPROVE') {
      return 'KYC 승인됨';
    } else {
      return '알 수 없음';
    }
  }

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
      body: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (response.isEmpty) {
            return Center(child: Text('공지가 없습니다.'),);
          } else {
            return ListView(
                children: response.map((notice) {
                  return NotificationCard(
                      title: getTitle(notice.status),
                      date: notice.createdDate,
                      description: notice.description);
                }).toList());
          }
        },
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  NotificationCard(
      {required this.title, required this.date, required this.description});

  final title;
  final date;
  final description;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(border: Border.all(color: gray04)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      date,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: gray08),
                    )
                  ],
                ),
                SizedBox(height: 8.0,),
                Text(
                  description,
                  style: TextStyle(color: gray08, fontSize: 16.0),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
