import 'package:sufismart/util/mode_util.dart';

class ApiEndPoint {
  String baseUrl = "https://api-suzuki.lemburkuring.id/api/";
  String baseUrlDebug = "https://api-suzuki.lemburkuring.id/api/";
  String getAllGenderUrl = "gender/getAll";
  String getAllCityUrl = "city/getAll";
  String loginCustomerUrl = "auth/customerLogin";
  String postCustomerRegisterUrl = "customer/register";
  String baseOcrUrl = "https://konteks-api.konvergen.ai/";
  String baseOcrUrlDebug = "https://konteks-api.konvergen.ai/";
  String postCustomerLoginUrl = "auth/customerLogin";
  String readOcrKtpUrl = "sfi/ktp";
  String postSavePositionUrl = "Service/savelocation";

  //sufismart
  String baseUrlSufismart = "https://sufismart.sfi.co.id/sufismart_ci/api/";
  String baseUrlDebugSufismart = "https://uat.sfi.co.id/sufismart_ci/api/";

  String getBannerUrl = "getBannerList";
  String getNewsHomeUrl = "getImgNews";
  String getListNewsUrl = "getNewsNew";
  String getListProductCategoryUrl = "getProductCategory";
  String getListProductUrl = "getProductList";
  String getListProductypeUrl = "getProductType";
  String getListBranchUrl = "getData_branch";
  String getListDataBranchByIdUrl = "getDataBranchID_new";
  String postLoginCustomerNewUrl = "action_login_new";
  String postContactUrl = "action_keluhan_new";
  String postForgotPassUrl = "action_resetpassword_new";
  String getAplikasiUrl = "getAplikasi_new";
  String postChangePassUrl = "update_password_new";
  String getGenderUrl = "getGender";
  String getJobUrl = "getJob";
  String postCustomerRegister = "registrasi_customer_new";
  String getConfirmOtpUser = "confirmasiUserOtp";
  String getResendOtpUser = "resendUserOtp";
  String getDetailInfoUser = "getDetailInfoUser";
  String postUpdateProfile = "updateProfilNew";

  String get url {
    if (ModeUtil.debugMode == true) {
      return baseUrlDebug;
    } else {
      return baseUrl;
    }
  }

  String get urlSufiSmart {
    if (ModeUtil.debugMode == true) {
      return baseUrlDebugSufismart;
    } else {
      return baseUrlSufismart;
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
    return url + loginCustomerUrl;
  }

  String customerRegister() {
    return url + postCustomerRegisterUrl;
  }

  String readKtp() {
    return ocr + readOcrKtpUrl;
  }

  String savePosition() {
    return url + postSavePositionUrl;
  }

  //sufismrat
  String getAllBanner() {
    return urlSufiSmart + getBannerUrl;
  }

  String getAllNewsHome() {
    return urlSufiSmart + getNewsHomeUrl;
  }

  String getListAllNews() {
    return urlSufiSmart + getListNewsUrl;
  }

  String getListAllProductCategory() {
    return urlSufiSmart + getListProductCategoryUrl;
  }

  String getListAllProduct({
    required String? categoryId,
  }) {
    return urlSufiSmart +
        "$getListProductUrl${categoryId != null ? "/$categoryId" : ""}";
  }

  String getListAllProductType({
    required String? productId,
  }) {
    return urlSufiSmart +
        "$getListProductypeUrl${productId != null ? "/$productId" : ""}";
  }

  String getListAllBranch() {
    return urlSufiSmart + getListBranchUrl;
  }

  String getListDetailBranchById({
    required String? kodeBranch,
    required double? lat,
    required double? lng,
  }) {
    return urlSufiSmart +
        "$getListDataBranchByIdUrl${kodeBranch != null ? "/$kodeBranch" : ""}${lat != null ? "/$lat" : ""}${lng != null ? "/$lng" : ""}";
  }

  String loginCustomerNew() {
    return urlSufiSmart + postLoginCustomerNewUrl;
  }

  String contactCustomer() {
    return urlSufiSmart + postContactUrl;
  }

  String forgotPassCustomer() {
    return urlSufiSmart + postForgotPassUrl;
  }

  String getAplikasiSufismart() {
    return urlSufiSmart + getAplikasiUrl;
  }

  String updateChangePass() {
    return urlSufiSmart + postChangePassUrl;
  }

  String getGender() {
    return urlSufiSmart + getGenderUrl;
  }

  String getJob() {
    return urlSufiSmart + getJobUrl;
  }

  String registerCustomer() {
    return urlSufiSmart + postCustomerRegister;
  }

  String confirmOtpUser({
    required String? otp,
    required String? userid,
  }) {
    return urlSufiSmart +
        "$getConfirmOtpUser${otp != null ? "/$otp" : ""}${userid != null ? "/$userid" : ""}";
  }

  String resendOtpUser({
    required String? userid,
  }) {
    return urlSufiSmart +
        "$getResendOtpUser${userid != null ? "/$userid" : ""}";
  }

  String detailInfoUser({
    required String? userid,
  }) {
    return urlSufiSmart +
        "$getDetailInfoUser${userid != null ? "/$userid" : ""}";
  }

  String updateProfilUser(){
    return urlSufiSmart + postUpdateProfile;
  }
}
