import 'package:flutter/material.dart';
import 'package:sufismart/component/circular_loader_component.dart';
import 'package:sufismart/model/contact_model.dart';
import 'package:sufismart/util/error_handling_util.dart';

class ContactViewModel extends ChangeNotifier {
  CircularLoaderController circularLoaderController =
      CircularLoaderController();

  TextEditingController namaLengkapTextEditingController =
      TextEditingController();
  TextEditingController notelpTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController pesanTextEditingController = TextEditingController();

  String _name = "";
  String get name => _name;
  set setName(String name) {
    _name = name;
    commit();
  }

  String _phone = "";
  String get phone => _phone;
  set setPhone(String phone) {
    _phone = phone;
    commit();
  }

  String _email = "";
  String get email => _email;
  set setEmail(String email) {
    _email = email;
    commit();
  }

  String _message = "";
  String get message => _message;
  set setMessage(String message) {
    _message = message;
    commit();
  }

  final GlobalKey<FormState> formKeyContact = GlobalKey<FormState>();

  void clearText() {
    namaLengkapTextEditingController.text = "";
    emailTextEditingController.text = "";
    notelpTextEditingController.text = "";
    pesanTextEditingController.text = "";
  }

  void sendKeluhan() {
    circularLoaderController.startLoading();
    ContactModel.sendkeluhan(
        contact: ContactModel(
      nama: namaLengkapTextEditingController.text,
      email: emailTextEditingController.text,
      phone: notelpTextEditingController.text,
      pesan: pesanTextEditingController.text,
    )).then((value) {
      if (value == true) {
        circularLoaderController.stopLoading(
            duration: const Duration(seconds: 3),
            isError: false,
            message: "Successfuly Send Data",
            onCloseCallBack: () {
              // if (onLoginSuccess != null) {
              //   onLoginSuccess(value);
              // }
            });
        clearText();
      } else if (value == false) {
        circularLoaderController.stopLoading(
            duration: const Duration(seconds: 3),
            isError: true,
            message: ErrorHandlingUtil.handleApiError("failed Send Data"));
      } else {
        circularLoaderController.forceStop();
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
