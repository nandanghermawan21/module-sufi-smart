import 'dart:io';

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
  // String baseUrlSufismart = "https://sufismart.sfi.co.id/sufismart_ci/api_sufi/";
  // String baseUrlDebugSufismart = "https://sufismart.sfi.co.id/sufismart_ci/api_sufi/";
  String baseUrlSufismart = "https://uat.sfi.co.id/sufismart_ci/api_sufi/";
  String baseUrlDebugSufismart = "https://uat.sfi.co.id/sufismart_ci/api_sufi/";

  String getBannerUrl = "getBannerListNew";
  String getNewsHomeUrl = "getImgNewsNew";
  String getListNewsUrl = "getApiNewsNew";
  String getListProductCategoryUrl = "getProductCategoryNew";
  String getListProductUrl = "getProductListNew";
  String getListProductypeUrl = "getProductTypeNew";
  String getListBranchUrl = "getDataBranchNew";
  String getListDataBranchByIdUrl = "getDataBranchID_new";
  String postLoginCustomerNewUrl = "actionLoginNewVersion";
  String postContactUrl = "actionKeluhanNew";
  String postForgotPassUrl = "actionResetPasswordNew";
  String getAplikasiUrl = "getAplikasiNew";
  String getAplikasiIosUrl = "getAplikasiNewIos";
  String postChangePassUrl = "updatePasswordNew";
  String getGenderUrl = "getGender";
  String getJobUrl = "getJob";
  String postCustomerRegisterNewUrl = "registrasiCustomerNewVersion";
  String getConfirmOtpUserUrl = "confirmasiUserOtpNew";
  String getResendOtpUserUrl = "resendUserOtpNew";
  String getDetailInfoUserUrl = "getDetailInfoUser";
  String postUpdateProfileUrl = "updateProfilNew";
  String getDataApplyUserUrl = "getListUserApply";
  String getDataNewsByIdUrl = "getDetailNewsId";
  String getDataPointUserUrl = "getPointUser";
  String getDataPointUserIosUrl = "getPointUserIos";
  String getDataNotifUrl = "getNotifAnnouncement";
  String getDataListMerchantUrl = "getListMerchant";
  String getDataHistoryPointUrl = "getHistoryPointUser";
  String postRedeemPointUrl = "submitRedeemPoint";

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
        "$getListDataBranchByIdUrl${kodeBranch != null ? "/$kodeBranch" : ""}${lat != null ? "/$lat" : 0}${lng != null ? "/$lng" : 0}";
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
    if(Platform.isAndroid){
      ModeUtil.debugPrint("check aplikasi android");
      return urlSufiSmart + getAplikasiUrl;
    }else if (Platform.isIOS){
      ModeUtil.debugPrint("check aplikasi ios");
      return urlSufiSmart + getAplikasiIosUrl;
    }else{
      ModeUtil.debugPrint("check aplikasi android");
      return urlSufiSmart + getAplikasiUrl;
    }
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
    return urlSufiSmart + postCustomerRegisterNewUrl;
  }

  String confirmOtpUser({
    required String? otp,
    required String? userid,
    required String? flag,
  }) {
    return urlSufiSmart +
        "$getConfirmOtpUserUrl${otp != null ? "/$otp" : ""}${userid != null ? "/$userid" : ""}${flag != null ? "/$flag" : ""}";
  }

  String resendOtpUser({
    required String? userid,
    required String? flag,
  }) {
    return urlSufiSmart +
        "$getResendOtpUserUrl${userid != null ? "/$userid" : ""}${flag != null ? "/$flag" : ""}";
  }

  String detailInfoUser({
    required String? userid,
  }) {
    return urlSufiSmart +
        "$getDetailInfoUserUrl${userid != null ? "/$userid" : ""}";
  }

  String updateProfilUser() {
    return urlSufiSmart + postUpdateProfileUrl;
  }

  String getDataApplyUser({
    required String? userid,
  }) {
    return urlSufiSmart +
        "$getDataApplyUserUrl${userid != null ? "/$userid" : ""}";
  }

  String getDetailNewsId({
    required String? id,
  }) {
    return urlSufiSmart + "$getDataNewsByIdUrl${id != null ? "/$id" : ""}";
  }

  String getPointUserId({
    required String? id,    
  }) {
    if(Platform.isAndroid){
      return urlSufiSmart + "$getDataPointUserUrl${id != null ? "/$id" : ""}";
    }else if(Platform.isIOS){
      return urlSufiSmart + "$getDataPointUserIosUrl${id != null ? "/$id" : ""}";
    }else{
      return urlSufiSmart + "$getDataPointUserUrl${id != null ? "/$id" : ""}";
    }    
  }

  String getDataNotif({
    required String? id,
  }) {
    return urlSufiSmart + "$getDataNotifUrl${id != null ? "/$id" : ""}";
  }

  String getMerchant({
    required String? userid,
  }) {
    return urlSufiSmart +
        "$getDataListMerchantUrl${userid != null ? "/$userid" : ""}";
  }

  String getHistoryPoint({
    required String? userid,
  }) {
    return urlSufiSmart +
        "$getDataHistoryPointUrl${userid != null ? "/$userid" : ""}";
  }

  String redeemPointSufismart() {
    return urlSufiSmart + postRedeemPointUrl;
  }
}
