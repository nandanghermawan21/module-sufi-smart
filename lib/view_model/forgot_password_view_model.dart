import 'package:flutter/material.dart';
import 'package:sufismart/model/forgotpass_model.dart';
import 'package:sufismart/util/error_handling_util.dart';

import '../component/circular_loader_component.dart';

class ForgotPasswordViewModel extends ChangeNotifier {
  CircularLoaderController circularLoaderController =
      CircularLoaderController();

  TextEditingController emailTextController = TextEditingController();

  String _email = "";
  String get email => _email;
  set setEmail(String email) {
    _email = email;
    commit();
  }

  final GlobalKey<FormState> formKeyContact = GlobalKey<FormState>();

  void sendForgotPassword() {
    circularLoaderController.startLoading();
    ForgotModel.sendForgotPasswod(
            forgotModel: ForgotModel(email: emailTextController.text))
        .then((value) {
      if (value != null) {
        if (value.stat == 0) {
          circularLoaderController.stopLoading(
              duration: const Duration(seconds: 5),
              isError: false,
              message: value.msg,
              onCloseCallBack: () {
                // if (onLoginSuccess2 != null) {
                //   onLoginSuccess2(value);
                // }
              });
              emailTextController.clear();
        } else if (value.stat == 1) {
          circularLoaderController.stopLoading(
              duration: const Duration(seconds: 3),
              isError: true,
              message: ErrorHandlingUtil.handleApiError(value.msg));
        }
      }
    }).catchError((onError) {
      circularLoaderController.stopLoading(
          duration: const Duration(seconds: 3),
          isError: true,
          message: ErrorHandlingUtil.handleApiError(onError));
    });
  }

  void commit() {
    notifyListeners();
  }
}
