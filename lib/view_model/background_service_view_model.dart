import 'package:flutter/material.dart';

class BackgroundServiceViewModel extends ChangeNotifier {
  void commit() {
    notifyListeners();
  }
}
