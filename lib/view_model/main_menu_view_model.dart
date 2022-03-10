import 'package:flutter/material.dart';
import 'package:sufismart/model/lang_model.dart';

class MainMenuViewModel extends ChangeNotifier {
  int selectedIndex = 0;
  TabController? tabController;
  GlobalKey bottomNavigationKey = GlobalKey();

  void onItemTapped(int index) {
    selectedIndex = index;
    tabController?.animateTo(index);
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
}
