import 'package:sufismart/model/akun_model.dart';
import 'package:flutter/material.dart';

class AkunViewModel extends ChangeNotifier {
  Future<void> onRefreshHomePage() async {
    return Future.delayed(const Duration(seconds: 5));
  }

  AkunModel? data = AkunModel.data();

  void commit() {
    notifyListeners();
  }
}
