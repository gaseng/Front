import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaseng/enum/kyc_enum.dart';
import 'package:gaseng/repositories/kyc_repository.dart';
import 'package:gaseng/utils/formatter.dart';
import 'package:gaseng/widgets/gaseng_general_button.dart';

import '../../constants/constant.dart';
import 'package:get/get.dart';

import '../../models/kyc/kyc_require_response.dart';
import '../../models/kyc/kyc_require_summary_response.dart';

class AdminKycDetailPage extends StatefulWidget {
  const AdminKycDetailPage({Key? key}) : super(key: key);

  @override
  State<AdminKycDetailPage> createState() => _AdminKycDetailPageState();
}

class _AdminKycDetailPageState extends State<AdminKycDetailPage> {
  KycRepository kycRepository = KycRepository();
  KycRequireResponse? kyc;
  late Future future;
  late int id;
  int status = 0;

  @override
  void initState() {
    id = Get.arguments;
    future = getKycRequire();
    super.initState();
  }

  void checkCrime() {
    if (status == 0) {
      kShowToast("범죄 이력 조회를 진행하세요.");
    } else {
      Get.toNamed('/admin/kyc/save', arguments: [kyc!.memId, kyc!.kycrId, status]);
    }
  }

  void getCrime() {
    setState(() {
      status++;
      if (status == 3) {
        status = 0;
      }
    });
  }

  Widget renderCrimeText() {
    String str = "";
    TextStyle style = TextStyle();
    if (status == 0) {
      str = '범죄 이력을 조회하지 않았습니다.';
      style = TextStyle();
    } else if (status == 1) {
      str = '✅ 범죄 이력이 없습니다.';
      style = TextStyle(color: Colors.green);
    } else if (status == 2) {
      str = '❌ 범죄 이력이 존재합니다.\nKYC 요청이 거절상태로 고정됩니다.';
      style = TextStyle(color: Colors.red);
    }
    return Text(str, style: style,);
  }

  Future<void> getKycRequire() async {
    kyc = await kycRepository.getKycRequire(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'KYC 요청 조회',
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
          if (kyc == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${kyc!.name}의 KYC',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20.0),
                    SizedBox(
                      height: 200.0,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(kyc!.faceImagePath)
                                )
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(kyc!.cardImagePath)
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40.0),
                    KycRequestItem(title: '이름', message: kyc!.name),
                    SizedBox(height: 12.0),
                    KycRequestItem(title: '생일', message: Formatter.customFormatter(kyc!.birth)),
                    SizedBox(height: 12.0),
                    KycRequestItem(title: '주소지', message: kyc!.address),
                    SizedBox(height: 12.0),
                    KycRequestItem(title: '세부 주소', message: kyc!.detail),
                    SizedBox(height: 12.0),
                    KycRequestItem(title: '직업', message: KycEnum.getJob(kyc!.job)),
                    SizedBox(height: 40.0),
                    Row(
                      children: [
                        renderCrimeText(),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            getCrime();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                            decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.all(Radius.circular(10.0))
                            ),
                            child: Text('범죄이력 조회', style: TextStyle(color: Colors.white, fontSize: 16.0),),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 40.0),
                    GestureDetector(
                      onTap: () {
                        checkCrime();
                      },
                      child: GasengGeneralButton(text: '확인', color: primary),
                    ),
                    SizedBox(height: 40.0),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class KycRequestItem extends StatelessWidget {
  KycRequestItem({required this.title, required this.message});

  final title;
  final message;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: gray10, fontSize: 12.0)),
        SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
          decoration: BoxDecoration(
            border: Border.all(color: gray06),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Text(message),
        )
      ],
    );
  }
}
