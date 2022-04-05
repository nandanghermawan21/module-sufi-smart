import 'package:sufismart/util/mode_util.dart';

class ApiEndPoint {
  String baseUrl = "http://api-suzuki.lemburkuring.id/api/";
  String baseUrlDebug = "http://api-suzuki.lemburkuring.id/api/";
  String getAllGenderUrl = "gender/getAll";
  String getAllCityUrl = "city/getAll";
  String loginCustomerUrl = "auth/customerLogin";
  String postCustomerRegisterUrl = "customer/register";
  String baseOcrUrl = "https://konteks-api.konvergen.ai/";
  String baseOcrUrlDebug = "https://konteks-api.konvergen.ai/";
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
      return baseOcrUrlDebug;
    }
  }

  String getAllGender() {
    return url + getAllGenderUrl;
  }

  String getAllCity() {
    return url + getAllCityUrl;
  }

  String loginCustomer() {
    return url + getAllCityUrl;
  }

  String customerRegister() {
    return url + postCustomerRegisterUrl;
  }

  String readKtp() {
    return ocr + readOcrKtpUrl;
  }
}
