import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';

class AplikasiModel {
  String? versi;
  String? phone;
  String? email;
  String? facebook;
  String? twitter;
  String? instagram;
  String? youtube;
  String? komunitas;

  AplikasiModel({
    this.versi,
    this.phone,
    this.email,
    this.facebook,
    this.twitter,
    this.instagram,
    this.youtube,
    this.komunitas,
  });

  factory AplikasiModel.fromJson(Map<String, dynamic> json) {
    return AplikasiModel(
      versi: json["versi"] as String?,
      phone: json["phone"] as String?,
      email: json["email"] as String?,
      facebook: json["facebook"] as String?,
      twitter: json["twitter"] as String?,
      instagram: json["instagram"] as String?,
      youtube: json["youtube"] as String?,
      komunitas: json["komunitas"] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'versi': versi,
      'phone': phone,
      'email': email,
      'facebook': facebook,
      'twitter': twitter,
      'instagram': instagram,
      'youtube': youtube,
      'komunitas': komunitas,
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
