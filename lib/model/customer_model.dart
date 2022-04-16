import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sufismart/model/customer_register_model.dart';
import 'package:http/http.dart' as http;
import 'package:sufismart/model/user_model.dart';
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/model/otp_model.dart';

class CustomerModel {
  int? id; //": 66,
  String? nik; //": "3205100206910005",
  String? imageId; //": "505728634194",
  String? imageUrl; //": "505728634194",
  String? fullName; //": "fudung",
  String? genderId; //": "L",
  String? genderName; //": "L",
  String? cityId; //": "1104",
  String? cityName; //": "1104",
  String? phoneNumber; //": "+6287724538083",
  String? username; //": "Dudung123",
  int? level; //": 1,
  String? isVerifiedPhone; //": "1",
  String?
      token; //": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjY2IiwidXNlcm5hbWUiOiJEdWR1bmcxMjMiLCJ0eXBlIjoiY3VzdG9tZXIiLCJpYXQiOjE2NDgyMDE2NDMsImV4cCI6MTY0ODIxOTY0M30.jPU5UvyuHcH5jg9uV1-wZ6Fsc97EKSTBEkXV79ltdcc"
  String? deviceid; 

  CustomerModel({
    this.id,
    this.nik,
    this.imageId,
    this.imageUrl,
    this.fullName,
    this.genderId,
    this.genderName,
    this.cityId,
    this.cityName,
    this.phoneNumber,
    this.username,
    this.level,
    this.isVerifiedPhone,
    this.token,
    this.deviceid
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json["id"] as int?,
      nik: json["nik"] as String?,
      imageUrl: json["imageUrl"] as String?,
      imageId: json["imageId"] as String?,
      fullName: json["fullName"] as String?,
      genderId: json["genderId"] as String?,
      genderName: json["genderName"] as String?,
      cityId: json["cityId"] as String?,
      cityName: json["cityName"] as String?,
      phoneNumber: json["phoneNumber"] as String?,
      username: json["username"] as String?,
      level: json["level"] as int?,
      token: json["token"] as String?,
      deviceid: json["deviceid"] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nik": nik,
      "imageUrl": imageUrl,
      "imageId": imageId,
      "fullName": fullName,
      "genderId": genderId,
      "genderName": genderName,
      "cityId": cityId,
      "cityName": cityName,
      "phoneNumber": phoneNumber,
      "username": username,
      "level": level,
      "token": token,
      "deviceid": deviceid,
    };
  }

  static Future<CustomerModel?> login({
    required UserModel user,
    ValueChanged<OtpModel>? onRequestOtp,
  }) {
    return http.post(Uri.parse(System.data.apiEndPoint.loginCustomer()),
        body: json.encode(user.toJson()),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }).then((value) {
      if (value.statusCode == 200) {
        ModeUtil.debugPrint(json.decode(value.body));
        return CustomerModel.fromJson(json.decode(value.body));
      } else if (value.statusCode == 403) {
        if (onRequestOtp != null) {
          onRequestOtp(OtpModel.fromJson(json.decode(value.body)));
        }
        return null;
      } else {
        throw value;
      }
    }).catchError((onError) {
      throw onError;
    });
  }

  static Future<OtpModel?> register({
    CustomerRegisterModel? registerModel,
  }) {
    return http.post(
      Uri.parse(
        System.data.apiEndPoint.customerRegister(),
      ),
      body: json.encode(registerModel?.toJson()),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
    ).then(
      (value) {
        if (value.statusCode == 200) {
          return OtpModel.fromJson(json.decode(value.body));
        } else {
          throw value;
        }
      },
    ).catchError((onError) {
      throw onError;
    });
  }

  static Future<CustomerModel?> getInfo({
    String? id,
  }) {
    return http.get(
      Uri.parse(
        System.data.apiEndPoint.getCustomerInfo(
          id: id,
        ),
      ),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
    ).then((value) {
      if (value.statusCode == 200) {
        return CustomerModel.fromJson(json.decode(value.body));
      } else {
        throw value;
      }
    }).catchError((onError) {
      throw onError;
    });
  }
}
