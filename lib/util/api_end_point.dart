import 'package:sufismart/util/mode_util.dart';

class ApiEndPoint {
  String baseUrl = "http://api-suzuki.lemburkuring.id/api/";
  String baseOcrUrl = "https://konteks-api.konvergen.ai/";
  String baseUrlDebug = "http://api-suzuki.lemburkuring.id/api/";
  String getAllGenderUrl = "gender/getAll";
  String postCustomerRegisterUrl = "customer/register";
  String postOcr = "sfi/ktp";
  String loginCustomerUrl = "auth/customerLogin";

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
      return baseOcrUrl;
    }
  }

  String getAllGender() {
    return url + getAllGenderUrl;
  }

  String customerRegister() {
    return url + postCustomerRegisterUrl;
  }

  String urlpostocr() {
    return ocr + postOcr;
  }

  String loginCustomer() {
    return url + loginCustomerUrl;
  }

}
