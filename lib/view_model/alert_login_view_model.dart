import 'package:flutter/material.dart';

class AlertLoginViewModel extends ChangeNotifier {
  void commit() {
    notifyListeners();
  }
}
