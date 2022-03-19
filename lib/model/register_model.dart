import 'dart:convert';
import 'dart:io';

import 'package:sufismart/model/otp_model.dart';

import 'package:sufismart/util/system.dart';
import 'package:http/http.dart' as http;

class RegisterModel {
  String? avatar;
  String? nik;
  String? fullname;
  String? genderid;
  String? cityid;
  String? phonenumber;
  String? username;
  String? password;
  String? deviceid;

  RegisterModel(
      {this.avatar,
      this.nik,
      this.fullname,
      this.genderid,
      this.cityid,
      this.phonenumber,
      this.username,
      this.password,
      this.deviceid});

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
        avatar: json["avatar"] as String,
        nik: json["avatar"] as String,
        fullname: json["avatar"] as String,
        genderid: json["avatar"] as String,
        cityid: json["avatar"] as String,
        phonenumber: json["avatar"] as String,
        username: json["avatar"] as String,
        password: json["avatar"] as String,
        deviceid: json["avatar"] as String);
  }

  Map<String, dynamic> tojson() {
    return {
      "avatar": avatar,
      "nik": nik,
      "fullname": fullname,
      "genderid": genderid,
      "cityid": cityid,
      "phonenumber": phonenumber,
      "username": username,
      "password": password,
      "deviceid": deviceid
    };
  }

  static Future<RegisterModel>? post({RegisterModel? registerModel}) {
    http.post(Uri.parse(System.data.apiEndPoint!.customerRegister()),
        body: registerModel?.tojson(),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }).then((value) {
      if (value.statusCode == 200) {
        OtpModel.fromJson(json.decode(value.body));
      } else {
        throw value;
      }
    }).catchError((onError) {
      throw onError;
    });
  }
}
