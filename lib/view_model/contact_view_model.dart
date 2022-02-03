import 'package:flutter/material.dart';

class ContactViewModel extends ChangeNotifier {
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

  void commit() {
    notifyListeners();
  }
}
