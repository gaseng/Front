import 'dart:io';

import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaseng/models/map/daum_post_model.dart';
import 'package:gaseng/models/sharehouse/sharehouse_request.dart';
import 'package:gaseng/pages/map/daum_post_web_view.dart';
import 'package:gaseng/repositories/sharehouse_repository.dart';
import 'package:gaseng/widgets/gaseng_bottom_button.dart';
import 'package:gaseng/widgets/gaseng_general_button.dart';
import 'package:gaseng/widgets/gaseng_text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:kpostal/kpostal.dart';

import '../../constants/constant.dart';
import '../../models/sharehouse/sharehouse_response.dart';
import '../../models/sharehouse/sharehouse_update_request.dart';

class EditSharehousePage extends StatefulWidget {
  @override
  State<EditSharehousePage> createState() => _EditSharehousePageState();
}

class _EditSharehousePageState extends State<EditSharehousePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SharehouseRepository sharehouseRepository = SharehouseRepository();
  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController addressDetailController = TextEditingController();

  SharehouseResponse? sharehouse;
  late DaumPostModel _dataModel;
  Future? future;
  late int id;

  @override
  void initState() {
    future = getSharehouse();
    super.initState();
  }

  getSharehouse() async {
    id = Get.arguments;
    sharehouse = await sharehouseRepository.get(id);
    if (sharehouse != null) {
      titleController.text = sharehouse!.title;
      desController.text = sharehouse!.description;
      addressController.text = sharehouse!.address;
      addressDetailController.text = sharehouse!.addressDetail;
      setState(() {});
    }
  }

  updateSharehouse() async {
    if (_formKey.currentState!.validate()) {
      SharehouseUpdateRequest request = SharehouseUpdateRequest(
          id: id,
          shrTitle: titleController.text,
          shrDescription: desController.text,
          shrAddress: addressController.text,
          shrAddressDetail: addressDetailController.text
      );
      int? code = await sharehouseRepository.update(request);

      if (code != null && code == 200) {
        kShowToast('수정되었습니다.');
        Get.back();
      }
    }
  }

  String? _validate(String? value) {
    if (value!.isEmpty) {
      return '해당 칸을 입력해주세요';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '쉐어하우스 글 등록',
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
                    Text('쉐어하우스',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: gray10,
                            fontSize: 12.0)),
                    SizedBox(height: 8.0),
                    GasengTextField(
                      labelText: '제목',
                      controller: titleController,
                      validator: _validate,
                    ),
                    SizedBox(height: 12.0),
                    GasengTextField(
                      labelText: '내용',
                      controller: desController,
                      keyboardType: TextInputType.multiline,
                      validator: _validate,
                    ),
                    SizedBox(height: 30.0),
                    Text('주소',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: gray10,
                            fontSize: 12.0)),
                    SizedBox(height: 8.0),
                    GasengTextField(
                      labelText: '주소',
                      controller: addressController,
                      validator: _validate,
                    ),
                    SizedBox(height: 12.0),
                    Row(
                      children: [
                        Expanded(
                          child: GasengTextField(
                            labelText: '세부주소',
                            controller: addressDetailController,
                            validator: _validate,
                          ),
                        ),
                        SizedBox(width: 12.0),
                        GestureDetector(
                          onTap: () async {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return DaumPostWebView();
                            })).then((value) {
                              if (value != null) {
                                setState(() {
                                  _dataModel = value;
                                });
                              }
                            });
                          },
                          child: GasengGeneralButton(
                            text: '우편번호 검색',
                            color: primary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 100.0),
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: [
              Spacer(),
              GestureDetector(
                onTap: updateSharehouse,
                child: GasengBottomButton(
                  text: '등록',
                  color: primary,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
