import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaseng/auth/SessionManager.dart';
import 'package:gaseng/widgets/gaseng_bottom_button.dart';
import 'package:gaseng/widgets/gaseng_general_button.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../constants/constant.dart';

class KycCardResultPage extends StatefulWidget {
  @override
  State<KycCardResultPage> createState() => _KycCardResultPageState();
}

class _KycCardResultPageState extends State<KycCardResultPage> {
  String scannedText = "";
  bool confirm = false;
  CroppedFile? imageFile;

  void isDriverLicense(String text) {
    print(text);
    RegExp regex = RegExp(r'^\w{2}-\w{2}-\w{6}-\w{2}$');
    if(regex.hasMatch(text)) {
      confirm = true;
    }
  }

  void getRecognizedText(CroppedFile image) async {
    final InputImage inputImage = InputImage.fromFilePath(image.path);
    final textRecognizer = GoogleMlKit.vision.textRecognizer(script: TextRecognitionScript.latin);
    RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

    await textRecognizer.close();
    scannedText = "";

    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        scannedText = scannedText + line.text + "\n";
        isDriverLicense(line.text);
      }
    }

    setState(() {});
  }

  @override
  void initState() {
    if (Get.arguments != null) {
      imageFile = Get.arguments as CroppedFile;
      getRecognizedText(imageFile!);
    }
    super.initState();
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
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.0),
            if (imageFile != null)
              Center(
                child: Image.file(
                  File(imageFile!.path),
                  width: 350.w,
                  height: 200.w,
                ),
              ),
            SizedBox(height: 50.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '다시 한번 확인해주세요',
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  '- 귀하의 신분증 아이디가 보이시나요?',
                  style: TextStyle(fontSize: 12.0, color: gray10),
                ),
                SizedBox(height: 8.0),
                Text(
                  '- 이미지의 텍스트를 깔끔하게 볼 수 있나요?',
                  style: TextStyle(fontSize: 12.0, color: gray10),
                ),
                SizedBox(height: 8.0),
                Text(
                  '- 반사된 빛이나 손가락으로 신분증을 가리지 않았나요?',
                  style: TextStyle(fontSize: 12.0, color: gray10),
                ),
              ],
            ),
            Spacer(),
            if (!confirm)
              Text('운전면허 아이디가 보이지 않습니다. 다시찍어주세요', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
            if (!confirm)
              SizedBox(height: 12.0),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: GasengGeneralButton(
                      text: '다시하기',
                      color: gray10,
                      textColor: Colors.white,
                    ),
                  ),
                ),
                if (confirm)
                  SizedBox(width: 12.0),
                if (confirm)
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        await SessionManager.saveCard(imageFile!.path);
                        Get.toNamed('/kyc/face/info');
                      },
                      child: GasengGeneralButton(
                        text: '다음',
                        color: primary,
                        textColor: Colors.white,
                      ),
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
