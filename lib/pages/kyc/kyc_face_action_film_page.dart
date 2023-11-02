import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaseng/constants/constant.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image/image.dart' as imglib;

import '../../widgets/processing.dart';

class KycFaceActionFilmPage extends StatefulWidget {
  const KycFaceActionFilmPage({Key? key}) : super(key: key);

  @override
  State<KycFaceActionFilmPage> createState() => _KycFaceActionFilmPageState();
}

class _KycFaceActionFilmPageState extends State<KycFaceActionFilmPage> {
  late CameraController _controller;
  late Future _initializeControllerFuture;
  late PoseDetector _poseDetector;
  XFile? imageFile;
  bool isProcess = false;
  bool isFace = false;
  late String info;
  late TextStyle infoStyle;
  late int mode;

  @override
  void initState() {
    setMode();
    info = "전면 카메라로 귀하의 얼굴을 촬영합니다.\n";
    setInfo();
    initializeController();
    super.initState();
  }

  initializeController() async {
    _initializeControllerFuture = availableCameras().then((value) {
      _controller = CameraController(value[1], ResolutionPreset.max,
          imageFormatGroup: ImageFormatGroup.bgra8888);
      _controller.initialize().then((_) {
        poseDetectorInitialize();
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
  }

  poseDetectorInitialize() {
    _poseDetector = PoseDetector(
      options: PoseDetectorOptions(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _poseDetector.close();
    super.dispose();
  }

  setMode() {
    Random random = Random();
    mode = random.nextInt(4);
  }

  setInfo() {
    if (mode == 0) {
      info += "고개를 좌측으로 숙여주세요.";
    } else if (mode == 1){
      info += "고개를 우측으로 숙여주세요.";
    } else if (mode == 2) {
      info += "얼굴과 왼손을 보여주세요.";
    } else {
      info += "얼굴과 오른손을 보여주세요.";
    }
    infoStyle = TextStyle(color: Colors.white);
  }

  Future<List<Pose>> processPicture(XFile picture) async {
    final imglib.Image? capturedImage =
    imglib.decodeImage(await File(picture.path).readAsBytes());
    final imglib.Image orientedImage = imglib.bakeOrientation(capturedImage!);
    final imageToBeProcessed =
    await File(picture.path).writeAsBytes(imglib.encodeJpg(orientedImage));

    final inputImage = InputImage.fromFilePath(imageToBeProcessed.path);
    return await _poseDetector.processImage(inputImage);
  }

  Future<void> takePicture() async {
    if (_controller.value.isInitialized) {
      XFile picture = await _controller.takePicture();
      List<Pose> poses = await processPicture(picture);

      if (poses.isEmpty) {
        print("얼굴을 인식시켜주세요.");
      } else {
        bool success = false;

        for (Pose pose in poses) {
          final leftEyeOuter = pose.landmarks[PoseLandmarkType.leftEyeOuter];
          final rightEyeOuter = pose.landmarks[PoseLandmarkType.rightEyeOuter];
          final leftIndex = pose.landmarks[PoseLandmarkType.leftIndex];
          final rightIndex = pose.landmarks[PoseLandmarkType.rightIndex];

          print("mode : " + mode.toString());
          print(leftEyeOuter!.likelihood);
          print(rightEyeOuter!.likelihood);
          print(leftIndex!.likelihood);
          print(rightIndex!.likelihood);

          success = brainPicture(leftEyeOuter, rightEyeOuter, leftIndex, rightIndex);

          if (success) {
            setState(() {
              isFace = true;
              info = "얼굴이 인식되었습니다.";
              infoStyle = TextStyle(color: Colors.white);
            });
            imageFile = picture;
          } else {
            setState(() {
              imageFile = picture;
              info = "행동이 인식되지 않았기 때문에 재촬영합니다.\n";
              setInfo();
              infoStyle =
                  TextStyle(color: Colors.red, fontWeight: FontWeight.bold);
            });
          }
        }
      }
    }
  }

  bool brainPicture(leftEyeOuter, rightEyeOuter, leftIndex, rightIndex) {
    if (mode == 0) {
      if (leftEyeOuter!.y - 250 > rightEyeOuter!.y) {
        return true;
      }
    } else if (mode == 1) {
      if (leftEyeOuter!.y < rightEyeOuter!.y - 250) {
        return true;
      }
    } else if (mode == 2) {
      if (leftIndex!.likelihood > 0.5 && leftEyeOuter!.likelihood > 0.7 && rightEyeOuter!.likelihood > 0.7) {
        return true;
      }
    } else {
      if (rightIndex!.likelihood > 0.5 && leftEyeOuter!.likelihood > 0.7 && rightEyeOuter!.likelihood > 0.7) {
        return true;
      }
    }
    return false;
  }

  Widget bottomButton() {
    if (isFace) {
      return GestureDetector(
        onTap: () {
          Get.toNamed('/kyc/submit');
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
          decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
          child: Text('다음', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () async {
          setState(() {
            isProcess = true;
          });
          await takePicture();
          setState(() {
            isProcess = false;
          });
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
      );
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
                            SizedBox(height: 40.0),
                            Text(
                              '특정 얼굴 촬영하기',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              info,
                              textAlign: TextAlign.center,
                              style: infoStyle,
                            ),
                            SizedBox(
                              height: 150.h,
                            ),
                            bottomButton(),
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
            Processing(isProcess: isProcess)
          ],
        ),
      ),
    );
  }
}
