import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';

class AplikasiModel {
  String? versi;
  String? phone;
  String? email;

  AplikasiModel({
    this.versi,
    this.phone,
    this.email,
  });

  factory AplikasiModel.fromJson(Map<String, dynamic> json) {
    return AplikasiModel(
      versi: json["versi"] as String?,
      phone: json["phone"] as String?,
      email: json["email"] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'versi': versi,
      'phone': phone,
      'email': email,
    };
  }

  static Future<AplikasiModel?> getAplikasi() {
    ModeUtil.debugPrint("call get aplikasi new api");
    return http
        .get(Uri.parse(System.data.apiEndPoint.getAplikasiSufismart()))
        .then((value) {
      if (value.statusCode == 200) {
        ModeUtil.debugPrint("call get aplikasi new api ${value.body}");
        return AplikasiModel.fromJson(json.decode(value.body));
      } else {
        ModeUtil.debugPrint("error not status code 200");
        throw value;
      }
    }).catchError((onError) {
      throw onError;
    });
  }
}
