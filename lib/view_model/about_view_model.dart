import 'package:flutter/foundation.dart';
import 'package:sufismart/model/aplikasi_model.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutViewModel extends ChangeNotifier {

  Future<AplikasiModel?> getDataAplikasi = AplikasiModel.getAplikasi();

   Future<void> openPhone(String phone) {
    return launch("tel:$phone");
  }

  Future<void> sendEmail(String email){
    //print(email);
    return launch('mailto:$email');
  }

  Future<void> sendWhatsapp(String notelp){
   return launch('https://wa.me/$notelp?text=Hello'); 
  }

  void commit() {
    notifyListeners();
  }
}
