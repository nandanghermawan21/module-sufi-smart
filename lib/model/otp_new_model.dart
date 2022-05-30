import 'dart:convert';

import 'package:sufismart/model/customernew_model.dart';
import 'package:sufismart/model/feedback_model.dart';
import 'package:http/http.dart' as http;
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';

class OtpNewModel {
  String? message;
  String? status;
  String? userid;
  DateTime? expired;

  OtpNewModel({
    this.message,
    this.status,
    this.userid,
    this.expired,
  });

  factory OtpNewModel.fromJson(Map<String, dynamic> json) {
    return OtpNewModel(
      message: json["message"] as String?,
      status: json["status"] as String?,
      userid: json["userid"] as String?,
      expired: json["expired"] == null
          ? null
          : DateTime.parse(json['expired'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'status': status,
      'userid': userid,
      'expired': expired,
    };
  }

  static Future<CustomerNewModel?> confirmOtp({
    required String? otp,
    required String? userid,
  }) {
    return http
        .get(Uri.parse(
            System.data.apiEndPoint.confirmOtpUser(otp: otp, userid: userid)))
        .then((value) {
      if (value.statusCode == 200) {
        ModeUtil.debugPrint("call get confirmOtp new api ${value.body}");
        return CustomerNewModel.fromJson(json.decode(value.body));
      } else {
        throw value;
      }
    }).catchError((onError) {
      throw onError;
    });
  }

  static Future<OtpNewModel?> resendOtp({
    required String? userid,
  }) {
    return http
        .get(Uri.parse(System.data.apiEndPoint.resendOtpUser(
      userid: userid,
    )))
        .then((value) {
      if (value.statusCode == 200) {
        return OtpNewModel.fromJson(json.decode(value.body));
      } else {
        throw value;
      }
    }).catchError((onError) {
      throw onError;
    });
  }
}
