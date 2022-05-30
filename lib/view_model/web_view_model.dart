import 'package:flutter/material.dart';

class WebViewModel extends ChangeNotifier{
  void commit() {
    notifyListeners();
  }
}