import 'dart:convert';
import 'dart:io';

import 'package:sufismart/model/otp_model.dart';
import 'package:http/http.dart' as http;
import 'package:sufismart/util/system.dart';

class RegisterModel {
  String? avatar;
  String? nik;
  String? fullName;
  String? genderId;
  String? cityId;
  String? phoneNumber;
  String? username;
  String? password;
  String? deviceId;

  RegisterModel({
    this.avatar,
    this.nik,
    this.fullName,
    this.genderId,
    this.cityId,
    this.phoneNumber,
    this.username,
    this.password,
    this.deviceId,
  });

  RegisterModel fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      avatar: json["avatar"] as String,
      nik: json["nik"] as String,
      fullName: json["fullName"] as String,
      genderId: json["genderId"] as String,
      cityId: json["cityId"] as String,
      phoneNumber: json["phoneNumber"] as String,
      username: json["username"] as String,
      password: json["password"] as String,
      deviceId: json["deviceId"] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "avatar": avatar,
      "nik": nik,
      "fullName": fullName,
      "genderId": genderId,
      "cityId": cityId,
      "phoneNumber": phoneNumber,
      "username": username,
      "password": password,
      "deviceId": deviceId,
    };
  }

  static Future<OtpModel?> post({
    RegisterModel? registerModel,
  }) {
    return http.post(
      Uri.parse(
        System.data.apiEndPoint!.customerRegister(),
      ),
      body: registerModel?.toJson(),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
    ).then(
      (value) {
        if (value.statusCode == 200) {
          OtpModel.fromJson(json.decode(value.body));
        } else {
          throw value;
        }
      },
    ).catchError((onError) {
      throw onError;
    });
  }
}
