import 'package:flutter/material.dart';
import 'package:sufismart/component/circular_loader_component.dart';
import 'package:sufismart/model/change_pass_model.dart';
import 'package:sufismart/util/error_handling_util.dart';
import 'package:sufismart/util/system.dart';

class ChangePassViewModel extends ChangeNotifier {
  CircularLoaderController circularLoaderController =
      CircularLoaderController();

  TextEditingController passwordlamaController = TextEditingController();
  TextEditingController passwordbaruController = TextEditingController();
  TextEditingController passwordconfirmController = TextEditingController();

  final GlobalKey<FormState> formKeyContact = GlobalKey<FormState>();

  bool _showPasswordLama = true;
  bool get showPasswordLama => _showPasswordLama;
  set setShowPasswordLama(bool showPasswordLama) {
    _showPasswordLama = showPasswordLama;
    commit();
  }

  bool _showPasswordBaru = true;
  bool get showPasswordBaru => _showPasswordBaru;
  set setShowPasswordbaru(bool showPasswordBaru) {
    _showPasswordBaru = showPasswordBaru;
    commit();
  }

  bool _showPasswordConfirm = true;
  bool get showPasswordConfirm => _showPasswordConfirm;
  set setShowPasswordConfirm(bool showPasswordConfirm) {
    _showPasswordConfirm = showPasswordConfirm;
    commit();
  }

  void sendChangePassword() {
    circularLoaderController.startLoading();
    if (passwordbaruController.text != passwordconfirmController.text) {
      circularLoaderController.stopLoading(
          duration: const Duration(seconds: 3),
          isError: true,
          message: System.data.strings!.validatePassNewAndConfirm);
    } else {
      ChangePassModel.sendChangePassword(
              changePassModel: ChangePassModel(
                  email: System.data.global.customerNewModel?.email,
                  passlama: passwordlamaController.text,
                  passbaru: passwordbaruController.text))
          .then((value) {
        if (value == true) {
          circularLoaderController.stopLoading(
              duration: const Duration(seconds: 3),
              isError: false,
              message: "Successfuly Change Password",
              onCloseCallBack: () {
                // if (onLoginSuccess != null) {
                //   onLoginSuccess(value);
                // }
              });
              passwordbaruController.clear();
              passwordlamaController.clear();
              passwordconfirmController.clear();
        } else {
          circularLoaderController.stopLoading(
              duration: const Duration(seconds: 3),
              isError: true,
              message:
                  ErrorHandlingUtil.handleApiError("failed Change password"));
        }
      }).catchError((onError) {
        circularLoaderController.stopLoading(
            duration: const Duration(seconds: 3),
            isError: true,
            message: ErrorHandlingUtil.handleApiError(onError));
      });
    }
  }

  void commit() {
    notifyListeners();
  }
}
