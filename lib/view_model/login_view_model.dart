import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sufismart/component/circular_loader_component.dart';
import 'package:sufismart/util/system.dart';

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

  void login() {
    System.data.loadingController.startLoading();
    Timer.periodic(
      const Duration(seconds: 3),
      (timer) {
        timer.cancel();
        System.data.loadingController.forceStop(
            // message: "Login Berhasil",
            // isError: true,
            );
      },
    );

    // emailTextEditingController.text.isEmpty
    //     ? setEmailValidation = true
    //     : setEmailValidation = false;
    // passwordTextEditingController.text.isEmpty
    //     ? setPasswordValidation = true
    //     : setPasswordValidation = false;
  }

  void commit() {
    notifyListeners();
  }
}
