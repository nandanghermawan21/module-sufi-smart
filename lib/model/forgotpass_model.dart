import 'dart:convert';
import 'dart:io';

import 'package:sufismart/model/feedback_model.dart';
import 'package:sufismart/util/mode_util.dart';
import 'package:http/http.dart' as http;
import 'package:sufismart/util/system.dart';

class ForgotModel {
  String? email;

  ForgotModel({
    this.email,
  });

  factory ForgotModel.fromjson(Map<String, dynamic> json) {
    return ForgotModel(
      email: json["email"] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }

  static Future<FeedbackModel?> sendForgotPasswod({
    required ForgotModel forgotModel,
  }) {
    ModeUtil.debugPrint("call get Send Keluhan new api");
    return http.post(Uri.parse(System.data.apiEndPoint.forgotPassCustomer()),
        body: json.encode(forgotModel.toJson()),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        }).then((value) {
      if (value.statusCode == 200) {
        ModeUtil.debugPrint(json.decode(value.body));
        ModeUtil.debugPrint("call get fogotpassword new api ${value.body}");
        return FeedbackModel.fromJson(json.decode(value.body));
      } else {
        ModeUtil.debugPrint("error not status code 200");
        throw value;
      }
    }).catchError((onError) {
      throw onError;
    });
  }
}
