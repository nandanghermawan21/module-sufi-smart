import 'package:flutter/material.dart';

class CreditSimulationViewModel extends ChangeNotifier {
  void commit() {
    notifyListeners();
  }
}
