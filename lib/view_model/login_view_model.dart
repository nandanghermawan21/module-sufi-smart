import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sufismart/component/cilcular_loader_component.dart';

import '../model/login_model.dart';
import '../util/error_handling.dart';
import '../util/system.dart';

class LoginViewModel extends ChangeNotifier {
  Future<void> onRefreshHomePage() async {
    return Future.delayed(const Duration(seconds: 5));
  }

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  CircularLoaderController circularLoaderController =
      CircularLoaderController();

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
  //   circularLoaderController.startLoading();
  //   Timer.periodic(
  //     const Duration(seconds: 10),
  //     (timer) {
  //       timer.cancel();
  //       circularLoaderController.stopLoading(
  //           message: "Login Berhasil",
  //           isError: false,
  //           duration: const Duration(seconds: 10));
  //     },
  //   );
  // }

  void login() {
    circularLoaderController.startLoading();
    LoginModel.post(
      loginModel: LoginModel(
          username: emailTextEditingController.text,
          password: passwordTextEditingController.text,
          deviceId: System.data.global.mmassagingToken),
    ).then((value) {
      circularLoaderController.stopLoading(
          message: "${value?.toJson()}", isError: false);
    }).catchError((onError) {
      circularLoaderController.stopLoading(
        message: ErrorHandlingUtil.handleApiError(onError),
        isError: true,
      );
    });
    // Timer.periodic(
    //   const Duration(seconds: 10),
    //   (timer) {
    //     timer.cancel();
    //     circularLoaderController.stopLoading(
    //         message: "Login Berhasil",
    //         isError: false,
    //         duration: const Duration(seconds: 10));
    //   },
    // );
  }

  void commit() {
    notifyListeners();
  }
}
