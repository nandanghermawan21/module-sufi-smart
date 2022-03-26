import 'package:flutter/material.dart';
import 'package:sufismart/component/cilcular_loader_component.dart';
import 'package:sufismart/model/customer_model.dart';
import 'package:sufismart/model/user_model.dart';

class LoginViewModel extends ChangeNotifier {
  CircularLoaderController circularLoaderController =
      CircularLoaderController();

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

  void login() {
    circularLoaderController.startLoading();
    CustomerModel.login(user: UserModel(
      username: emailTextEditingController.text,
      password: passwordTextEditingController.text,
      deviceId: 
    ));
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
