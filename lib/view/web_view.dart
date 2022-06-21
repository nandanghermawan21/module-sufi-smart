import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/view_model/web_view_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewSufi extends StatefulWidget {
  final String? urlweb;
  const WebViewSufi({
    Key? key,
    this.urlweb,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WebViewState();
  }
}

class _WebViewState extends State<WebViewSufi> {
  WebViewModel webViewModel = WebViewModel();
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: System.data.color!.background,
      body: Stack(
        children: [
          WebView(
            initialUrl: widget.urlweb ?? "",
            onPageFinished: (finish) {
              setState(() {
                isLoading = false;
              });
            },            
            javascriptMode: JavascriptMode.unrestricted,
            
            javascriptChannels: {
              JavascriptChannel(
                  name: 'backSuccess',
                  onMessageReceived: (JavascriptMessage message) {
                    ModeUtil.debugPrint("message ${message.message}");
                    webViewModel.successOrder();
                  }),
              JavascriptChannel(
                  name: 'viewPdf',
                  onMessageReceived: (JavascriptMessage message) {
                    ModeUtil.debugPrint("message ${message.message}");
                    webViewModel.openbrowser(message.message);
                  }),
              JavascriptChannel(
                  name: 'telepon',
                  onMessageReceived: (JavascriptMessage message) {
                    ModeUtil.debugPrint("message ${message.message}");
                    webViewModel.openPhone(message.message);
                  }),
              JavascriptChannel(
                  name: 'sendEmail',
                  onMessageReceived: (JavascriptMessage message) {
                    ModeUtil.debugPrint("message ${message.message}");
                    webViewModel.sendEmail(message.message);
                  }),
              JavascriptChannel(
                  name: 'Print',
                  onMessageReceived: (JavascriptMessage message) {
                    ModeUtil.debugPrint("message ${message.message}");
                    webViewModel.openbrowser(message.message);
                  }),
            },
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(),
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: System.data.color!.mainColor,
      title: Image.asset(
        "assets/logo_sfi_white.png",
        fit: BoxFit.cover,
        height: 30,
      ),
    );
  }

  // Widget view(String url){
  //   return WebView(
  //      initialUrl: url,
  //    );
  // }
}
