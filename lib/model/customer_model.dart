import 'dart:convert';
import 'dart:io';

import 'package:sufismart/model/customer_register_model.dart';
import 'package:http/http.dart' as http;
import 'package:sufismart/util/system.dart';
import 'package:sufismart/model/otp_model.dart';

class CustomerModel {
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
}
