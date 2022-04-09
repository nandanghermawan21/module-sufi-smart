import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:sufismart/util/mode_util.dart';

class OtpModel {
  String? resendUrl; //": "string",
  String? confirmUrl; //": "2022-03-19T06:36:03.576Z",
  String? jsonData; //": "string",
  DateTime? expired; //": "2022-03-19T06:36:03.577Z"

  OtpModel({
    this.resendUrl,
    this.confirmUrl,
    this.jsonData,
    this.expired,
  });

  static OtpModel fromJson(Map<String, dynamic> json) {
    return OtpModel(
      resendUrl: json["resendUrl"] as String?,
      confirmUrl: json["confirmUrl"] as String?,
      jsonData: json["jsonData"] as String?,
      expired: json["expired"] == null
          ? null
          : DateTime.parse(json['expired'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "resendUrl": resendUrl,
      "confirmUrl": confirmUrl,
      "jsonData": jsonData,
      "expired": expired?.toIso8601String(),
    };
  }

  static Future<OtpModel?> resend({
    required String url,
  }) {
    ModeUtil.debugPrint(url);
    return http.post(
      Uri.parse(
        url,
      ),
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

  static Future<T> confirm<T>({
    required String url,
    required String otp,
    required T Function(Map<String, dynamic> json) jsonReader,
    String? key,
  }) {
    return http.post(
      Uri.parse(
        url + "&" + (key ?? "otp") + "=" + otp,
      ),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
    ).then(
      (value) {
        if (value.statusCode == 200) {
          return jsonReader(json.decode(value.body));
        } else {
          throw value;
        }
      },
    ).catchError((onError) {
      throw onError;
    });
  }
}
