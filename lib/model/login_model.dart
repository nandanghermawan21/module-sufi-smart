import 'dart:convert';
import 'dart:io';

import 'package:sufismart/model/customer_model.dart';
import 'package:http/http.dart' as http;
import 'package:sufismart/util/system.dart';

class LoginModel {
  String? username;
  String? password;
  String? deviceId;

  LoginModel({
    this.username,
    this.password,
    this.deviceId,
  });

  LoginModel fromJson(Map<String, dynamic> json) {
    return LoginModel(
      username: json["username"] as String?,
      password: json["password"] as String?,
      deviceId: json["deviceId"] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "password": password,
      "deviceId": deviceId,
    };
  }

  static Future<CustomerModel?> post({
    LoginModel? loginModel,
  }) {
    return http.post(Uri.parse(System.data.apiEndPoint!.loginCustomer()),
        body: json.encode(loginModel?.toJson()),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }).then(
      (value) {
        if (value.statusCode == 200) {
          return CustomerModel.fromJson(json.decode(value.body));
        } else {
          throw value;
        }
      },
    ).catchError(
      (onError) {
        throw onError;
      },
    );
  }
}
