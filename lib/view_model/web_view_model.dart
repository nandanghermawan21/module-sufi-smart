import 'package:flutter/material.dart';
import 'package:sufismart/util/system.dart';
import 'package:url_launcher/url_launcher.dart';

class WebViewModel extends ChangeNotifier {

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

  void commit() {
    notifyListeners();
  }
}
