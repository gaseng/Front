import 'package:flutter/material.dart';
import 'package:gaseng/enum/kyc_enum.dart';
import 'package:gaseng/repositories/kyc_repository.dart';
import 'package:gaseng/widgets/gaseng_general_button.dart';
import 'package:gaseng/widgets/gaseng_text_field.dart';
import 'package:gaseng/widgets/processing.dart';

import 'package:get/get.dart';
import '../../constants/constant.dart';
import '../../models/kyc/kyc_save_request.dart';

class AdminKycSavePage extends StatefulWidget {
  const AdminKycSavePage({Key? key}) : super(key: key);

  @override
  State<AdminKycSavePage> createState() => _AdminKycSavePageState();
}

class _AdminKycSavePageState extends State<AdminKycSavePage> {
  KycRepository kycRepository = KycRepository();
  TextEditingController controller = TextEditingController();
  late int memId;
  late int kycrId;
  late int status;
  int current = 0;
  bool isProcess = false;

  @override
  void initState() {
    setInitialData();
    super.initState();
  }

  Future<void> submit() async {
    setState(() {
      isProcess = true;
    });

    if (current != 2 && controller.text == "") {
      kShowToast("사유를 입력해주세요");
      return;
    }

    String result = KycEnum.getResult(current);
    KycSaveRequest request = KycSaveRequest(status: result, description: controller.text);
    dynamic statusCode = await kycRepository.save(kycrId, request);
    if (statusCode == 200) {
      kShowToast("저장되었습니다.");
      Get.offAllNamed('/admin');
    }

    setState(() {
      isProcess = false;
    });
  }

  void setInitialData() {
    List<int> list = Get.arguments;
    memId = list[0];
    kycrId = list[1];
    status = list[2];
    if (status == 2) {
      current = 1;
    }
  }

  Widget renderButton() {
    return Row(
      children: [
        if (status != 2)
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  current = 0;
                });
              },
              child: GasengGeneralButton(
                text: '반려',
                color: current == 0 ? primary : Colors.white,
                textColor: current == 0 ? Colors.white : Colors.black,
              ),
            ),
          ),
        SizedBox(width: 12.0),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                current = 1;
              });
            },
            child: GasengGeneralButton(
              text: '거절',
              color: current == 1 ? primary : Colors.white,
              textColor: current == 1 ? Colors.white : Colors.black,
            ),
          ),
        ),
        SizedBox(width: 12.0),
        if (status != 2)
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  current = 2;
                });
              },
              child: GasengGeneralButton(
                text: '승인',
                color: current == 2 ? primary : Colors.white,
                textColor: current == 2 ? Colors.white : Colors.black,
              ),
            ),
          ),
      ],
    );
  }

  Widget renderTextField() {
    if (current != 2) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '사유',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: gray10,
              fontSize: 12.0,
            ),
          ),
          SizedBox(height: 8.0),
          GasengTextField(
            labelText: '사유',
            controller: controller,
          )
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'KYC 요청 저장',
          style: TextStyle(color: Colors.black, fontSize: 16.0),
        ),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('KYC 결정',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: gray10,
                        fontSize: 12.0)),
                SizedBox(height: 8.0),
                renderButton(),
                SizedBox(height: 30.0),
                renderTextField(),
                Spacer(),
                GestureDetector(
                  onTap: submit,
                  child: GasengGeneralButton(
                    text: '결정',
                    color: primary,
                  ),
                ),
              ],
            ),
          ),
          Processing(isProcess: isProcess)
        ],
      ),
    );
  }
}
