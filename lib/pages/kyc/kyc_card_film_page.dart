import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaseng/auth/SessionManager.dart';
import 'package:gaseng/constants/constant.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:http/http.dart' as http;

class KycCardFilmPage extends StatefulWidget {
  const KycCardFilmPage({Key? key}) : super(key: key);

  @override
  State<KycCardFilmPage> createState() => _KycCardFilmPageState();
}

class _KycCardFilmPageState extends State<KycCardFilmPage> {
  late CameraController _controller;
  late Future _initializeControllerFuture;
  XFile? imageFile;
  CroppedFile? _croppedFile;

  @override
  void initState() {
    _initializeControllerFuture = availableCameras().then((value) {
      _controller = CameraController(value[0], ResolutionPreset.max);
      _controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      }).catchError((Object e) {
        if (e is CameraException) {
          switch (e.code) {
            case 'CameraAccessDenied':
              break;
            default:
              break;
          }
        }
      });
    });
    super.initState();
  }

  Future<void> takePicture() async {
    if (!_controller.value.isInitialized) {
      return;
    }

    try {
      final XFile picture = await _controller.takePicture();
      setState(() {
        imageFile = picture;
      });
    } catch (e) {
      print("Error taking picture: $e");
    }
  }

  Future<void> _cropImage() async {
    if (imageFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: context,
            presentStyle: CropperPresentStyle.dialog,
            boundary: const CroppieBoundary(
              width: 520,
              height: 520,
            ),
            viewPort:
            const CroppieViewPort(width: 480, height: 480, type: 'circle'),
            enableExif: true,
            enableZoom: true,
            showZoomer: true,
          ),
        ],
      );
      if (croppedFile != null) {
        _croppedFile = croppedFile;
        http.MultipartFile cardFile = await http.MultipartFile.fromPath('card', _croppedFile!.path);
        SessionManager.card = cardFile;
        Get.toNamed('kyc/card/result', arguments: _croppedFile);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'KYC 인증',
            style: TextStyle(color: Colors.black, fontSize: 16.0),
          ),
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('여기서 종료하시겠습니까?'),
                    content: Text('여기서 종료하시면 모든 과정을 처음부터 진행해야 합니다.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text('취소'),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.offAllNamed('/main');
                        },
                        child: Text('확인'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
        ),
        backgroundColor: gray12,
        body: Stack(
          children: [
            FutureBuilder(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Stack(
                    children: [
                      CameraPreview(_controller),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Spacer(),
                            Container(
                              width: 330.w,
                              height: 200.w,
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                            ),
                            SizedBox(height: 40.0),
                            Text(
                              '신분증 촬영하기',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              '운전면허증 사진의 앞부분을 촬영합니다.\n 프레임에 맞게 신분증을 놓아주세요.',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () async {
                                await takePicture();
                                await _cropImage();
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 41.0,
                                    backgroundColor: gray10,
                                  ),
                                  CircleAvatar(
                                    radius: 40.0,
                                    backgroundColor: gray12,
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      size: 30.0,
                                      color: gray10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 40.0),
                          ],
                        ),
                      )
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
