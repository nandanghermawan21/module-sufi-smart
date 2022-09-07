import 'package:flutter/foundation.dart';
import 'package:sufismart/model/aplikasi_model.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutViewModel extends ChangeNotifier {

  Future<AplikasiModel?> getDataAplikasi = AplikasiModel.getAplikasi();

   Future<void> openPhone(String phone) {
    return launchUrl(Uri.parse("tel:$phone"));
  }

  Future<void> sendEmail(String email){
    //print(email);
    return launchUrl(Uri.parse('mailto:$email'));
  }  

  Future<void> sendWhatsapp(String notelp){
   return launch('https://wa.me/$notelp?text=Hello'); 
  }

   Future<void> openbrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  void commit() {
    notifyListeners();
  }
}
