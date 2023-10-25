import 'dart:io';

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

class AddSharehousePage extends StatefulWidget {
  @override
  State<AddSharehousePage> createState() => _AddSharehousePageState();
}

class _AddSharehousePageState extends State<AddSharehousePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SharehouseRepository sharehouseRepository = SharehouseRepository();
  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController addressDetailController = TextEditingController();

  late DaumPostModel _dataModel;
  List<XFile>? _imageFiles;
  XFile? _poster;

  uploadSharehouse() async {
    if (_formKey.currentState!.validate()) {
      if (_poster == null) {
        kShowToast('poster를 등록해주세요');
        return;
      } else if (_imageFiles == null) {
        kShowToast('image를 1개 이상 넣어주세요');
        return;
      }
      List<dynamic> lists = [];
      for (XFile xFile in _imageFiles!) {
        dynamic file = await http.MultipartFile.fromPath('files', xFile.path);
        lists.add(file);
      }

      http.MultipartFile poster =
      await http.MultipartFile.fromPath('poster', _poster!.path);
      SharehouseRequest request = SharehouseRequest(
          lists: lists,
          shrTitle: titleController.text,
          shrDescription: desController.text,
          shrAddress: addressController.text,
          shrAddressDetail: addressDetailController.text);
      int? code = await sharehouseRepository.create(request, poster);

      if (code != null && code == 200) {
        kShowToast('업로드 되었습니다.');
        Get.offAllNamed('/main');
      }
    }
  }

  String? _validate(String? value) {
    if (value!.isEmpty) {
      return '해당 칸을 입력해주세요';
    }
    return null;
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImages =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 10);

    if (pickedImages != null) {
      setState(() {
        _poster = pickedImages;
      });
    }
  }

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage(imageQuality: 10);

    if (pickedImages != null) {
      setState(() {
        _imageFiles = pickedImages;
      });
    }
  }

  Widget renderPoster() {
    if (_poster != null) {
      ImageProvider<Object> image;
      if (kIsWeb) {
        image = NetworkImage(_poster!.path);
      } else {
        image = FileImage(File(_poster!.path));
      }

      return GestureDetector(
        onTap: _pickImage,
        child: Container(
          width: double.infinity,
          height: 200.h,
          decoration: BoxDecoration(
            color: gray06,
            image: DecorationImage(image: image, fit: BoxFit.cover),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.photo_library_outlined),
              SizedBox(width: 4),
              Text(
                '포스터 이미지 첨부',
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: _pickImage,
        child: Container(
          width: double.infinity,
          height: 200.h,
          color: gray06,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.photo_library_outlined),
              SizedBox(width: 4),
              Text(
                '포스터 이미지 첨부',
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget renderImages() {
    if (_imageFiles != null) {
      return Wrap(
        children: _imageFiles!.map((image) {
          ImageProvider<Object> img;
          if (kIsWeb) {
            img = NetworkImage(image!.path);
          } else {
            img = FileImage(File(image!.path));
          }
          return Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
                image: DecorationImage(image: img, fit: BoxFit.cover)),
          );
        }).toList(),
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
                    renderPoster(),
                    SizedBox(height: 12.0),
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
                    SizedBox(height: 12.0),
                    Row(
                      children: [
                        Spacer(),
                        TextButton(
                          onPressed: _pickImages,
                          child: Text(
                            '사진 첨부',
                            style: TextStyle(
                                color: Colors.indigo,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    renderImages(),
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
                onTap: uploadSharehouse,
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
