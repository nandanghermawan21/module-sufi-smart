import 'dart:async';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sufismart/util/api_end_point.dart';
import 'package:sufismart/util/colour.dart';
import 'package:sufismart/util/databases.dart';
import 'package:sufismart/util/strings.dart';
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/one_signal_messaging.dart';

import 'global.dart';

class Data extends ChangeNotifier {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  BuildContext get context => navigatorKey.currentContext!;
  Global global = Global();
  ApiEndPoint? apiEndPoint;
  Strings? strings;
  Colour? color;
  OneSignalMessaging? oneSignalMessaging;
  List<Permission> permission = [];
  ValueChanged<Uri?>? deepLinkingHandler;
  SharedPreferences? session;
  Databases? database;
  Function(Database?, int)? onCreateDb;

  Data();

  Future<void> initialize() async {
    await _initSharedPreference();
    await _initDatabse();
  }

  void commit() {
    notifyListeners();
  }

  Future<bool> _initSharedPreference() async {
    session = await SharedPreferences.getInstance();
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
