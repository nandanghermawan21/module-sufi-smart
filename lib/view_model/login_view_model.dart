import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sufismart/component/cilcular_loader_component.dart';
import 'package:sufismart/component/pin_component.dart';
import 'package:sufismart/model/customer_model.dart';
import 'package:sufismart/model/otp_model.dart';
import 'package:sufismart/model/user_model.dart';
import 'package:sufismart/util/error_handling_util.dart';
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';

class LoginViewModel extends ChangeNotifier {
  Future<void> onRefreshHomePage() async {
    return Future.delayed(const Duration(seconds: 5));
  }

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  CircularLoaderController circularLoaderController =
      CircularLoaderController();
  PinComponentController pinComponentController = PinComponentController();

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

  void login({
    ValueChanged<CustomerModel>? onLoginSuccess,
  }) {
    circularLoaderController.startLoading();
    CustomerModel.login(
      user: UserModel(
        deviceId: System.data.global.messagingToken,
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
            message: "Login success",
            duration: const Duration(seconds: 2),
            onCloseCallBack: () {
              if (onLoginSuccess != null) {
                onLoginSuccess(value);
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
