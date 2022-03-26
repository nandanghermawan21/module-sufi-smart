import 'package:sufismart/util/mode_util.dart';

class ApiEndPoint {
  String baseUrl = "http://api-suzuki.lemburkuring.id/api/";
  String baseUrlDebug = "http://api-suzuki.lemburkuring.id/api/";
  String baseOcrUrl = "https://konteks-api.konvergen.ai/";
  String baseOcrUrlGDebug = "https://konteks-api.konvergen.ai/";
  String getAllGenderUrl = "gender/getAll";
  String postCustomerRegisterUrl = "customer/register";
  String readOcrKtpUrl = "sfi/ktp";
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
      return baseOcrUrlGDebug;
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

  String readKtp() {
    return ocr + readOcrKtpUrl;
  }

  String loginCustomer() {
    return url + loginCustomerUrl;
  }
}
