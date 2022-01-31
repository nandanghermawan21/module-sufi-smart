import 'package:flutter/material.dart';

class MainMenuViewModel extends ChangeNotifier {
  int selectedIndex = 0;
  void onItemTapped(int index) {
    selectedIndex = index;
    commit();
  }

  Widget? body;

  void commit() {
    notifyListeners();
  }
}
