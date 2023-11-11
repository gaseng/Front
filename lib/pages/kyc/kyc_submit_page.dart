import 'dart:io';

import 'package:camera/camera.dart';
import 'package:daum_postcode_search/daum_postcode_search.dart';
import 'package:flutter/material.dart';
import 'package:gaseng/auth/SessionManager.dart';
import 'package:gaseng/models/kyc/kyc_submit_request.dart';
import 'package:gaseng/models/map/daum_post_model.dart';
import 'package:gaseng/repositories/kyc_repository.dart';
import 'package:gaseng/utils/validator.dart';
import 'package:gaseng/widgets/processing.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../../constants/constant.dart';
import '../../widgets/gaseng_general_button.dart';
import '../../widgets/gaseng_text_field.dart';
import '../daum_post_search_page.dart';

class KycSubmitPage extends StatefulWidget {
  @override
  State<KycSubmitPage> createState() => _KycSubmitPageState();
}

class _KycSubmitPageState extends State<KycSubmitPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController birthController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController addressDetailController = TextEditingController();
  KycRepository kycRepository = KycRepository();
  DateTime initialDate = DateTime.now();
  late List<String> list;
  late String dropdownValue;
  late File file;
  bool isProcess = false;

  @override
  void initState() {
    list = ['학생', '직장인', '무직'];
    dropdownValue = list.first;
    super.initState();
  }

  void submit() async {
    setState(() {
      isProcess = true;
    });

    if (SessionManager.card != null && SessionManager.face != null) {
      http.MultipartFile cardFile = SessionManager.card!;
      http.MultipartFile faceFile = SessionManager.face!;

      if (_formKey.currentState!.validate()) {
        await kycRepository.submit(KycSubmitRequest(
          name: nameController.text,
          birth: initialDate,
          address: addressController.text,
          detail: addressDetailController.text,
          card: cardFile,
          face: faceFile,
          job: dropdownValue,
        ));

        SessionManager.card = null;
        SessionManager.face = null;

        await SessionManager.toWait();
        kShowToast("제출되었습니다.");
        Get.offAllNamed('/main');
      }
    }
    setState(() {
      isProcess = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'KYC 인증',
          style: TextStyle(color: Colors.black, fontSize: 16.0),
        ),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '이름',
                      style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: gray08),
                    ),
                    // Image.file(file: ),
                    SizedBox(height: 12.0),
                    GasengTextField(
                      labelText: '이름',
                      controller: nameController,
                      validator: Validator.validate,
                    ),
                    SizedBox(height: 12),
                    Text(
                      '생일',
                      style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: gray08),
                    ),
                    SizedBox(height: 12.0),
                    Row(
                      children: [
                        Text(
                          '${DateFormat('yyyy-MM-dd').format(initialDate)}',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        SizedBox(width: 12.0),
                        TextButton(
                          onPressed: () async {
                            final selectedDate = await showDatePicker(
                              context: context,
                              initialDate: initialDate,
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now(),
                            );
                            if (selectedDate != null) {
                              setState(() {
                                initialDate = selectedDate;
                              });
                            }
                          },
                          child: Text('날짜 선택'),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Text(
                          '주소지',
                          style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: gray08),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () async {
                            DataModel model =
                                await Get.to(() => DaumPostSearchPage());
                            setState(() {
                              addressController.text = model.address;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4.0),
                            decoration: BoxDecoration(
                                color: primary,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                            child: Text(
                              '우편번호 검색',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 12.0),
                    GasengTextField(
                      labelText: '주소지',
                      controller: addressController,
                      enabled: false,
                      validator: Validator.validate,
                    ),
                    SizedBox(height: 12.0),
                    GasengTextField(
                      labelText: '세부 주소',
                      controller: addressDetailController,
                      validator: Validator.validate,
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      '직업',
                      style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: gray08),
                    ),
                    SizedBox(height: 12.0),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: DropdownButton(
                        value: dropdownValue,
                        items: list.map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 40.0),
                    GestureDetector(
                      onTap: submit,
                      child: GasengGeneralButton(
                        text: 'KYC 제출',
                        color: primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Processing(isProcess: isProcess)
        ],
      ),
    );
  }
}
