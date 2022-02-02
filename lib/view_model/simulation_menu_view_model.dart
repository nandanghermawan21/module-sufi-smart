import 'package:flutter/material.dart';

class SimulasiMenuViewModel extends ChangeNotifier {
  int _modeMenu = 1;
  int get modeMenu {
    return _modeMenu;
  }

  set modeMenu(int mode) {
    _modeMenu = mode;
    commit();
  }

  void commit() {
    notifyListeners();
  }
}
