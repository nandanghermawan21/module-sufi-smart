import 'package:sufismart/util/mode_util.dart';

class ApiEndPoint {
  String baseUrl = "http://api-suzuki.lemburkuring.id/api/";
  String baseUrlDebug = "http://api-suzuki.lemburkuring.id/api/";
  String baseUrlOcr = "https://konteks-api.konvergen.ai/";
  String baseUrlOcrDebug = "https://konteks-api.konvergen.ai/";
  String getAllGenderUrl = "gender/getAll";
  String getAllCityUrl = "city/getAll";
  String loginCustomerUrl = "auth/customerLogin";
  String postCustomerRegisterUrl = "customer/register";
  String postReadKtpUrl = "sfi/ktp";

  String get url {
    if (ModeUtil.debugMode == true) {
      return baseUrlDebug;
    } else {
      return baseUrl;
    }
  }

  String get ocr {
    if (ModeUtil.debugMode == true) {
      return baseUrlOcrDebug;
    } else {
      return baseUrlOcr;
    }
  }

  String getAllGender() {
    return url + getAllGenderUrl;
  }

  String getAllCity() {
    return url + getAllCityUrl;
  }

  String loginCustomer() {
    return url + loginCustomerUrl;
  }

  String customerRegister() {
    return url + postCustomerRegisterUrl;
  }

  String readKtp() {
    return ocr + postReadKtpUrl;
  }
}
