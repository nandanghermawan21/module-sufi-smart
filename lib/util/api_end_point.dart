import 'dart:io';
import 'package:dio/dio.dart';
import 'package:sufismart/model/ktp_model.dart';
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';

class ApiEndPoint {
  String baseUrl = "http://api-suzuki.lemburkuring.id/api/";
  String baseUrlDebug = "http://api-suzuki.lemburkuring.id/api/";
  String baseOcrUrl = "https://konteks-api.konvergen.ai/";
  String baseOcrUrlDebug = "https://konteks-api.konvergen.ai/";
  String getAllGenderUrl = "gender/getAll";
  String loginCustomerUrl = "auth/customerLogin";
  String postCustomerRegisterUrl = "customer/register";
  String postCustomerLoginUrl = "auth/customerLogin";
  String readOcrKtpUrl = "sfi/ktp";

  String get url {
    if (ModeUtil.debugMode == true) {
      return baseUrlDebug;
    } else {
      return baseUrl;
    }
  }

  String get ocr {
    if (ModeUtil.debugMode == true) {
      return baseOcrUrl;
    } else {
      return baseUrlDebug;
    }
  }

  String getAllGender() {
    return url + getAllGenderUrl;
  }

  String customerRegister() {
    return url + postCustomerRegisterUrl;
  }

  String readKtp() {
    return ocr + readOcrKtpUrl;
  }

  String loginCustomer() {
    return url + postCustomerLoginUrl;
  }

  static Future<KtpModel> readFromImage({
    String? key,
    File? file,
  }) async {
    return Dio()
        .post(
      System.data.apiEndPoint.readKtp(),
      data: FormData.fromMap({
        "key": key,
        "image": await MultipartFile.fromFile(file!.path,
            filename: file.path.split("/").last),
      }),
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      ),
    )
        .then(
      (value) {
        if (value.statusCode == 200) {
          if (value.data["status"] == "Success") {
            return KtpModel.fromJson(value.data["read"]);
          } else {
            throw "image tidak valid";
          }
        } else {
          throw "image tidak valid";
        }
      },
    ).catchError(
      (onError) {
        throw "image tidak valid";
      },
    );
  }
}
