import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';

class ChangePassModel {
  String? email;
  String? passlama;
  String? passbaru;

  ChangePassModel({
    this.email,
    this.passlama,
    this.passbaru,
  });

  factory ChangePassModel.fromJson(Map<String, dynamic> json) {
    return ChangePassModel(
      email: json["email"] as String?,
      passlama: json["passlama"] as String?,
      passbaru: json["passbaru"] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'passlama': passlama,
      'passbaru': passbaru,
    };
  }

  static Future<bool> sendChangePassword({
    required ChangePassModel changePassModel,
  }) {
    return http.post(Uri.parse(System.data.apiEndPoint.updateChangePass()),
        body: json.encode(changePassModel.toJson()),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json'
        }).then((value) {
      ModeUtil.debugPrint(
          "call get send change password new api 2 ${value.body}");
      if (value.statusCode == 200) {
        var response = json.decode(value.body);
        ModeUtil.debugPrint(
            "call get send change password new api 3 ${response["status"]}");
        if (response["status"] == "1") {
          return true;
        } else {
          return false;
        }
      } else {
        throw value;
      }
    }).catchError((onError) {
      throw onError;
    });
  }
}
