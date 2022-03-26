import 'package:flutter/material.dart';
import 'package:sufismart/component/cilcular_loader_component.dart';
import 'package:sufismart/model/customer_model.dart';
import 'package:sufismart/model/user_model.dart';
import 'package:sufismart/util/system.dart';
import '../component/pin_component.dart';
import '../model/otp_model.dart';
import '../util/error_handling_util.dart';
import '../util/mode_util.dart';

class LoginViewModel extends ChangeNotifier {
  CircularLoaderController circularLoaderController =
      CircularLoaderController();

PinComponentController pinComponentController = PinComponentController();

  Future<void> onRefreshHomePage() async {
    return Future.delayed(const Duration(seconds: 5));
  }

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  bool _emailValidation = false;
  bool get emailValidation => _emailValidation;
  set setEmailValidation(bool emailValidation) {
    _emailValidation = emailValidation;
    commit();
  }

  bool _passwordValidation = false;
  bool get passwordValidation => _passwordValidation;
  set setPasswordValidation(bool passwordValidation) {
    _passwordValidation = passwordValidation;
    commit();
  }

  bool _showPassword = false;
  bool get showPassword => _showPassword;
  set setShowPassword(bool showPassword) {
    _showPassword = showPassword;
    commit();
  }

  String? validateText(String value) {
    if (!(value.length > 5) && value.isNotEmpty) {
      return "should contain more than 5 characters";
    }
    return null;
  }

  bool validLogin() {
    bool valid = false;
    valid = showPassword ? true : false;
    valid = passwordValidation ? true : false;
    return valid;
  }


// void login() {
//     circularLoaderController.startLoading();
//     CustomerModel.login(
//         user: UserModel(
//             username: emailTextEditingController.text,
//             password: passwordTextEditingController.text,
//             deviceId: System.data.global.mmassagingToken),
//         onRequestOtp: (otp) {
//           PinComponent.open(
//               context: System.data.context,
//               controller: pinComponentController,
//               timer: DateTime.now().toUtc().difference(otp.expired!),
//               onTapResend: (pin) {
//                 pinComponentController.value.loadingController.startLoading();
//                 OtpModel.resend(url: otp.resendUrl ?? "").then((otp2) {
//                   pinComponentController.value.timerController.start(
//                     duration: DateTime.now().toUtc().difference(otp2!.expired!),
//                   );
//                 }).catchError((onErrorOtp2) {
//                   pinComponentController.value.loadingController.stopLoading(
//                       isError: true,
//                       message: ErrorHandlingUtil.handleApiError(onErrorOtp2));
//                 });
//               },
//               onTapSend: (pin) {
//                 pinComponentController.value.loadingController.startLoading();
//                 OtpModel.confirm<CustomerModel>(
//                     url: otp.confirmUrl ?? "",
//                     otp: pin,
//                     jsonReader: (json) {
//                       return CustomerModel.fromJson(json);
//                     }).then((value) {
//                   circularLoaderController.stopLoading(
//                     duration: const Duration(seconds: 3),
//                     isError: false,
//                     message: "Login with OTP success.",
//                   );
//                 }).catchError((onErrorOTP3) {
//                   pinComponentController.value.loadingController.stopLoading(
//                       isError: true,
//                       message: ErrorHandlingUtil.handleApiError(onErrorOTP3));
//                 });
//               });
//         });

//     // emailTextEditingController.text.isEmpty
//     //     ? setEmailValidation = true
//     //     : setEmailValidation = false;
//     // passwordTextEditingController.text.isEmpty
//     //     ? setPasswordValidation = true
//     //     : setPasswordValidation = false;
//   }
  

 void login({
    ValueChanged<CustomerModel>? onLoginSuccess,
  }) {
    circularLoaderController.startLoading();
    CustomerModel.login(
      user: UserModel(
        deviceId: System.data.global.mmassagingToken,
        password: passwordTextEditingController.text,
        username: emailTextEditingController.text,
      ),
      onRequestOtp: (otp) {
        ModeUtil.debugPrint("masuk ke request otp");
        ModeUtil.debugPrint(otp.toJson());
        PinComponent.open(
          context: System.data.context,
          controller: pinComponentController,
          title: "Input OTP",
          timer: DateTime.now().difference(otp.expired!.toLocal()),
          onTapResend: (val) {
            pinComponentController.value.loadingController.startLoading();
            OtpModel.resend(
              url: System.data.apiEndPoint.url + (otp.resendUrl ?? ""),
            ).then(
              (value) {
                pinComponentController.value.loadingController.forceClose();
                pinComponentController.value.timerController.start(
                  duration: DateTime.now().difference(otp.expired!.toLocal()),
                );
              },
            ).catchError((onError) {
              pinComponentController.value.loadingController.stopLoading(
                  isError: true,
                  message: ErrorHandlingUtil.handleApiError(onError));
            });
          },
          onTapSend: (val) {
            OtpModel.confirm<CustomerModel>(
              url: System.data.apiEndPoint.url + (otp.confirmUrl ?? ""),
              otp: val,
              jsonReader: (json) {
                return CustomerModel.fromJson(json);
              },
            ).then(
              (value) {
                circularLoaderController.stopLoading(
                  isError: false,
                  message: "Login success",
                  duration: const Duration(seconds: 2),
                  onCloseCallBack: () {
                    if (onLoginSuccess != null) {
                      onLoginSuccess(value);
                    }
                  },
                );
              },
            ).catchError((onError) {
              pinComponentController.value.loadingController.stopLoading(
                  isError: true,
                  message: ErrorHandlingUtil.handleApiError(onError));
            });
          },
        );
      },
    ).then(
      (value) {
        if (value != null) {
          circularLoaderController.stopLoading(
            isError: false,
            message: "Login success without OTP",
            duration: const Duration(seconds: 2),
            onCloseCallBack: () {
              if (onLoginSuccess != null) {
                onLoginSuccess(value);
              }else{
                print("Login success, callback null");
              }
            },
          );
        } else {
          circularLoaderController.forceClose();
        }
      },
    ).catchError((onError) {
      circularLoaderController.stopLoading(
          isError: true, message: ErrorHandlingUtil.handleApiError(onError));
    });
  }

  void commit() {
    notifyListeners();
  }
}
