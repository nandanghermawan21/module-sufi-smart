import 'dart:convert';
import 'dart:io';

import 'package:sufismart/model/otp_new_model.dart';
import 'package:sufismart/util/mode_util.dart';
import 'package:http/http.dart' as http;
import 'package:sufismart/util/system.dart';

class CustomerRegisterNewModel {
  String? namalengkap;
  String? nohp;
  String? email;
  String? pass;
  String? tanggallahir;
  String? pekerjaan;
  String? gender;
  String? deviceplatform;
  String? token;
  String? version;

  CustomerRegisterNewModel({
    this.namalengkap,
    this.nohp,
    this.email,
    this.pass,
    this.tanggallahir,
    this.pekerjaan,
    this.gender,
    this.deviceplatform,
    this.token,
    this.version,
  });

  factory CustomerRegisterNewModel.fromJson(Map<String, dynamic> json) {
    return CustomerRegisterNewModel(
      namalengkap: json["namalengkap"] as String?,
      nohp: json["nohp"] as String?,
      email: json["email"] as String?,
      pass: json["pass"] as String?,
      tanggallahir: json["tanggallahir"] as String?,
      pekerjaan: json["pekerjaan"] as String?,
      gender: json["gender"] as String?,
      deviceplatform: json["deviceplatform"] as String?,
      token: json["token"] as String?,
      version: json["version"] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'namalengkap': namalengkap,
      'nohp': nohp,
      'email': email,
      'pass': pass,
      'tanggallahir': tanggallahir,
      'pekerjaan': pekerjaan,
      'gender': gender,
      'deviceplatform': deviceplatform,
      'token': token,
      'version': version,
    };
  }

  static Future<OtpNewModel?> sendRegistrasi({
    required CustomerRegisterNewModel? customerRegisterNewModel,
  }) {
    ModeUtil.debugPrint("call Send registrasi new api");
    return http.post(Uri.parse(System.data.apiEndPoint.registerCustomer()),
        body: json.encode(customerRegisterNewModel?.toJson()),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        }).then((value) {
      if (value.statusCode == 200) {
        ModeUtil.debugPrint(json.decode(value.body));
        ModeUtil.debugPrint("call get otpmodel new api ${value.body}");
        return OtpNewModel.fromJson(json.decode(value.body));
      }else{
        ModeUtil.debugPrint("error status code 200");
        throw value;
      }
    }).catchError((onError){
      throw onError;
    });
  }
}
