import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sufismart/model/customernew_model.dart';
import 'package:sufismart/model/lang_model.dart';
import 'package:sufismart/util/enum.dart';
import 'package:sufismart/util/mode_util.dart';
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

  void commit() {
    notifyListeners();
  }

  void readSessions() {
    if (System.data.session!.getString(SessionKey.user) == "") return;
    System.data.global.customerNewModel = CustomerNewModel.fromJson(json.decode(
      System.data.session!.getString(SessionKey.user) ?? "{}",
    ));
    System.data.global.token = System.data.global.customerNewModel?.deviceid;
    ModeUtil.debugPrint(
        "Curent Customer ${System.data.global.customerNewModel?.toJson()}");
    ModeUtil.debugPrint("start save user position");
    // service.restartService();
  }
}
