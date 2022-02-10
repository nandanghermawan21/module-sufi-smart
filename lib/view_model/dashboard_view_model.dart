import 'package:flutter/material.dart';

class DashboardViewModel extends ChangeNotifier {
  void commit() {
    notifyListeners();
  }
}
