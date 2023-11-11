import 'package:daum_postcode_search/daum_postcode_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class DaumPostSearchPage extends StatefulWidget {
  const DaumPostSearchPage({Key? key}) : super(key: key);

  @override
  State<DaumPostSearchPage> createState() => _DaumPostSearchPageState();
}

class _DaumPostSearchPageState extends State<DaumPostSearchPage> {
  bool _isError = false;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '다음 주소 검색',
          style: TextStyle(color: Colors.black, fontSize: 16.0),
        ),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: DaumPostcodeSearch(
          webPageTitle: "다음 주소 검색",
          initialOption: InAppWebViewGroupOptions(),
          onConsoleMessage: ((controller, consoleMessage) {}),
          onLoadError: ((controller, url, code, message) {}),
          onLoadHttpError: (controller, url, statusCode, description) {},
          onProgressChanged: (controller, progress) {},
          androidOnPermissionRequest: (controller, origin, resources) async {
            return PermissionRequestResponse(
                resources: resources,
                action: PermissionRequestResponseAction.GRANT);
          },
        ),
      ),
    );
  }
}
