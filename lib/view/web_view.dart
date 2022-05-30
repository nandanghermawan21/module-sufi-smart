import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sufismart/util/system.dart';
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
      body: WebView(
        initialUrl: widget.urlweb ?? "",
         javascriptMode: JavascriptMode.unrestricted, 
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
