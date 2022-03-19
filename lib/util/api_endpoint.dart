import 'package:sufismart/util/mode_util.dart';

class ApiEndPoint {
  String baseUrl = "http://api-suzuki.lemburkuring.id/api/";
  String baseUrlDebug = "http://api-suzuki.lemburkuring.id/api/";
  String getAllGenderUrl = "gender/getAll";
  String getAllCityUrl = "city/getAll";
  String loginCustomerUrl = "auth/customerLogin";
  String postCustomerRegisterUrl = "/api/customer/register";

  String get url {
    if (ModeUtil.debugMode == true) {
      return baseUrlDebug;
    } else {
      return baseUrl;
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
}
