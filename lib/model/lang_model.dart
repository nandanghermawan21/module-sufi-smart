import 'dart:convert';

import 'package:sufismart/recource/string_id_id.dart';
import 'package:sufismart/recource/strings_en_us.dart';
import 'package:sufismart/util/enum.dart';
import 'package:sufismart/util/system.dart';

class LangModel {
  String? lang;
  String? name;
  String? flag;

  LangModel({
    this.lang,
    this.name,
    this.flag,
  });

  factory LangModel.fromJson(Map<String, dynamic> json) {
    return LangModel(
      lang: json["lang"],
      name: json["name"],
      flag: json["flag"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "lang": lang,
      "name": name,
      "flag": flag,
    };
  }

  static LangModel getSettedOrDefaultLang() {
    String? _langJson =
        System.data.sharedPreferences?.getString(PreferenceKey.lang);

    if ((_langJson ?? "").isNotEmpty) {
      try {
        return LangModel.fromJson(json.decode(_langJson ?? ""));
      } catch (e) {
        return getDefaultLang();
      }
    }
    return getDefaultLang();
  }

  static LangModel getDefaultLang() {
    return LangModel(
      lang: "ID-id",
      name: "Indonesia",
      flag: "assets/flag_ID_id.png",
    );
  }

  static List<LangModel> getSupportedLang() {
    return [
      LangModel(
        lang: "ID-id",
        name: "Indonesia",
        flag: "assets/flag_ID_id.png",
      ),
      LangModel(
        lang: "EN-us",
        name: "Englis",
        flag: "assets/flag_EN_us.png",
      ),
    ];
  }

  static applyLang(LangModel langModel) {
    switch (langModel.lang) {
      case "ID-id":
        System.data.strings = StringsIdId();
        break;
      case "EN-us":
        System.data.strings = StringsEnUs();
        break;
    }
    System.data.sharedPreferences
        ?.setString(PreferenceKey.lang, json.encode(langModel.toJson()));
    System.data.commit();
  }
}
