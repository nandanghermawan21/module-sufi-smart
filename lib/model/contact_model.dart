import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';

class ContactModel {
  String? nama;
  String? email;
  String? phone;
  String? pesan;

  ContactModel({
    this.nama,
    this.email,
    this.phone,
    this.pesan,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      nama: json["nama"] as String?,
      email: json["email"] as String?,
      phone: json["phone"] as String?,
      pesan: json["pesan"] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'email': email,
      'phone': phone,
      'pesan': pesan,
    };
  }

  static Future<bool> sendkeluhan ({
    required ContactModel contact,
  }) {
    ModeUtil.debugPrint("call get Send Keluhan new api");
    return http.post(Uri.parse(System.data.apiEndPoint.contactCustomer()),
        body: json.encode(contact.toJson()),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }).then((value) {
      ModeUtil.debugPrint("call get send Keluhan new api 2 ${value.body}");
      if (value.statusCode == 200) {
        return true;
      } else {
        ModeUtil.debugPrint("error not status Code 200->");
        return false;
      }
    }).catchError((onError) {
      ModeUtil.debugPrint("masuk on error send keluhan" + onError.toString());
      throw onError;
    });
  }
}
