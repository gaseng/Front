import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaseng/constants/constant.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image/image.dart' as imglib;

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

  @override
  void initState() {
    info = "전면 카메라로 귀하의 얼굴을 촬영합니다.";
    infoStyle = TextStyle(color: Colors.white);
    _initializeControllerFuture = availableCameras().then((value) {
      _controller = CameraController(value[1], ResolutionPreset.max,
          imageFormatGroup: ImageFormatGroup.bgra8888);
      _controller.initialize().then((_) {
        _poseDetector = PoseDetector(
          options: PoseDetectorOptions(),
        );

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

  @override
  void dispose() {
    _controller.dispose();
    _poseDetector.close();
    super.dispose();
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

      if(poses.isEmpty) {
        print("얼굴을 인식시켜주세요.");
      } else {
        for (Pose pose in poses) {
          pose.landmarks.forEach((_, landmark) {
            final type = landmark.type;
            final x = landmark.x;
            final y = landmark.y;
          });

          final leftEyeOuter = pose.landmarks[PoseLandmarkType.leftEyeOuter];
          final rightEyeOuter = pose.landmarks[PoseLandmarkType.rightEyeOuter];

          print("left eye : ${leftEyeOuter!.y}");
          print("right eye : ${rightEyeOuter!.y}");

          if (leftEyeOuter!.y - 250 > rightEyeOuter!.y) {
            print("고개를 왼쪽으로 기울이셨네요!");
          } else if (leftEyeOuter!.y < rightEyeOuter!.y - 250) {
            print("고개를 오른쪽으로 기울이셨네요!");
          } else {
            print("다시해주세요");
          }
        }

        // if (faces.isNotEmpty) {
        //   setState(() {
        //     setState(() {
        //       isFace = true;
        //       info = "얼굴이 인식되었습니다.";
        //       infoStyle = TextStyle(color: Colors.white);
        //     });
        //     imageFile = picture;
        //   });
        // } else {
        //   setState(() {
        //     imageFile = picture;
        //     info = "얼굴이 인식되지 않았기 때문에 재촬영합니다.\n전면 카메라로 귀하의 얼굴을 촬영합니다.";
        //     infoStyle = TextStyle(color: Colors.red, fontWeight: FontWeight.bold);
        //   });
        // }
      }
    }
  }

  Widget bottomButton() {
    if (isFace) {
      return GestureDetector(
        onTap: () {
          Get.toNamed('/kyc/face-action/info');
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

  Widget processing() {
    if (isProcess) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black45,
        child: Center(
          child: Text(
            '처리중입니다.',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      );
    } else {
      return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          processing()
        ],
      ),
    );
  }
}
