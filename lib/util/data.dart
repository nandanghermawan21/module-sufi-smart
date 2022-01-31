import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sufismart/util/colour.dart';
import 'package:sufismart/util/databases.dart';
import 'package:sufismart/util/strings.dart';
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/one_signal_messaging.dart';

import 'global.dart';

class Data extends ChangeNotifier {
  Global global = Global();
  Strings? strings;
  Colour? color;
  OneSignalMessaging? oneSignalMessaging;
  List<Permission> permission = [];
  ValueChanged<Uri?>? deepLinkingHandler;
  SharedPreferences? sharedPreferences;
  Databases? database;
  Function(Database?, int)? onCreateDb;

  Data() {
    _initSharedPreference();
    _initDatabse();
  }

  void commit() {
    notifyListeners();
  }

  Future<bool> _initSharedPreference() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return true;
  }

  Future<bool> _initDatabse() async {
    database = await Databases().initializeDb(
      onCreate: (db, version) {
        ModeUtil.debugPrint("Database information :");
        ModeUtil.debugPrint("path                 : ${db?.path}");
        ModeUtil.debugPrint("version              : $version");
        if (onCreateDb != null) {
          onCreateDb!(db, version);
        }
      },
    );
    return true;
  }
}
