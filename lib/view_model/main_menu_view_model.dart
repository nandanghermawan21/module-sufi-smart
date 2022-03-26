import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sufismart/model/customer_model.dart';
import 'package:sufismart/model/lang_model.dart';
import 'package:sufismart/util/enum.dart';
import 'package:sufismart/util/system.dart';

class MainMenuViewModel extends ChangeNotifier {
  int selectedIndex = 0;
  void onItemTapped(int index) {
    selectedIndex = index;
    commit();
  }

  List<LangModel> langs = LangModel.getSupportedLang();
  LangModel? _lang = LangModel.getSettedOrDefaultLang();
  LangModel? get lang {
    // _lang ??= LangModel.getDefaultLang();
    return _lang;
  }

  set lang(LangModel? lang) {
    _lang = lang;
    LangModel.applyLang(_lang!);
    commit();
  }

  void initializeLang() {
    LangModel.applyLang(_lang!);
  }

  Widget? body;

  void readSession() {
    if (System.data.session!.getString(SessionKey.user) != null ||
        System.data.session!.getString(SessionKey.user) != "") {
      System.data.global.customerModel = CustomerModel.fromJson(
          json.decode(System.data.session!.getString(SessionKey.user)!));
      System.data.global.token = System.data.global.customerModel?.token;
      System.data.commit();
    }
  }

  void commit() {
    notifyListeners();
  }
}
