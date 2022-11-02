import 'package:flutter/material.dart';
import 'package:sufismart/util/system.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../util/mode_util.dart';

class WebViewModel extends ChangeNotifier {
  
  late WebViewController controllerGlobal;

  Future<bool> exitApp(BuildContext context) async {
  // if (await controllerGlobal.canGoBack() == true) {
  //   //ModeUtil.debugPrint("onwill goback");
  //   controllerGlobal.goBack();
  //   return Future.value(true);
  // } else {
  //   // Scaffold.of(context).showSnackBar(
  //   //   const SnackBar(content: Text("No back history item")),
  //   // );
  //   return Future.value(false);
  // }
  
  if (await controllerGlobal.canGoBack()) {
    ModeUtil.debugPrint("onwill goback");
    controllerGlobal.goBack();
    return Future.value(true);
  } else {
    // Scaffold.of(context).showSnackBar(
    //   const SnackBar(content: Text("No back history item")),
    // );
    ModeUtil.debugPrint("onwill goback");
    return Future.value(false);
  }
}

  Future<void> openPhone(String phone) {
    //return launch("tel:$phone");
    return launchUrl(Uri.parse("tel:$phone"));
  }

  Future<void> sendEmail(String email){
    //print(email);
    //return launch('mailto:$email');
    return launchUrl(Uri.parse('mailto:$email'));
  }
  
  void successOrder() {
    Navigator.of(System.data.context).pop();
    commit();
  }

  Future<void> openbrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  // Future<void> openbrowser(String url) async {
  //   if (await canLaunchUrl(Uri.parse(url))) {
  //     await launchUrl(Uri.parse(url));
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  void tapBackHome(){
    Navigator.of(System.data.context).pop();
  }

  void commit() {
    notifyListeners();
  }
}
