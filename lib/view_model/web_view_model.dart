import 'package:flutter/material.dart';
import 'package:sufismart/util/system.dart';
import 'package:url_launcher/url_launcher.dart';

class WebViewModel extends ChangeNotifier {

  Future<void> openPhone(String phone) {
    return launch("tel:$phone");
  }

  Future<void> sendEmail(String email){
    //print(email);
    return launch('mailto:$email');
  }
  
  void successOrder() {
    Navigator.of(System.data.context).pop();
    commit();
  }

  Future<void> openbrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void commit() {
    notifyListeners();
  }
}
