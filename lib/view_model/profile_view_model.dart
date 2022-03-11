import 'package:flutter/material.dart';

class ProfileViewModel extends ChangeNotifier {
  void commit() {
    notifyListeners();
  }
}
