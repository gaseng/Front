import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../models/map/daum_post_model.dart';

class DaumPostWebView extends StatefulWidget {
  @override
  State<DaumPostWebView> createState() => _DaumPostWebViewState();
}

class _DaumPostWebViewState extends State<DaumPostWebView> {
  final InAppLocalhostServer _localhostServer = InAppLocalhostServer(port: 9000, );
  late InAppWebViewController _controller;
  bool isLoading = true;
  bool isError = false;

  DaumPostModel _dataSetting(Map<String, dynamic> map) {
    return DaumPostModel(
      map["address"],
      map["roadAddress"],
      map["jibunAddress"],
      map["sido"],
      map["sigungu"],
      map["bname"],
      map["roadname"],
      map["buildingName"],
      map["addressEnglish"],
      map["roadAddressEnglish"],
      map["jibunAddressEnglish"],
      map["sidoEnglish"],
      map["sigunguEnglish"],
      map["bnameEnglish"],
      map["roadnameEnglish"],
      map["zonecode"],
      map["sigunguCode"],
      map["bcode"],
      map["buildingCode"],
      map["roadnameCode"],
      map["addressType"],
      map["apartment"],
      map["userLanguageType"],
      map["userSelectedType"],
    );
  }

  @override
  void initState() {
    super.initState();
    _localhostServer.start();
  }

  @override
  void dispose() {
    _localhostServer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(
                url: Uri.parse(
                    "http://localhost:8080/assets/html/daum_postcode.html")),
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                useShouldOverrideUrlLoading: true,
                mediaPlaybackRequiresUserGesture: false,
              ),
              android: AndroidInAppWebViewOptions(
                useHybridComposition: true,
              ),
              ios: IOSInAppWebViewOptions(
                allowsInlineMediaPlayback: true,
              ),
            ),
            onWebViewCreated: (controller) {
              _controller = controller;
              _controller.addJavaScriptHandler(
                  handlerName: 'onSelectAddress',
                  callback: (args) {
                    Map<String, dynamic> _fromMap = args.first;
                    DaumPostModel _data = _dataSetting(_fromMap);
                    Navigator.of(context).pop(_data);
                  });
            },
            onLoadStop: (controller, url) {
              setState(() {
                if (_localhostServer.isRunning()) {
                  isLoading = false;
                } else {
                  _localhostServer.start().then((value) {
                    _controller.reload();
                  });
                }
              });
            },
            onLoadError: ((controller, url, code, message) {
              setState(() {
                isError = true;
              });
            }),
            onLoadHttpError: (controller, url, statusCode, description) {
              setState(() {
                isError = true;
              });
            },
            androidOnPermissionRequest: (controller, origin, resources) async {
              return PermissionRequestResponse(
                  resources: resources,
                  action: PermissionRequestResponseAction.GRANT);
            },
          ),
        ],
      ),
    );
  }
}
