import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sufismart/util/one_signal_messaging.dart';

import 'global.dart';

class Data extends ChangeNotifier {
  Global global = Global();
  OneSignalMessaging? oneSignalMessaging;
  List<Permission> permission = [];
  ValueChanged<Uri?>? deepLinkingHandler;

  void commit() {
    notifyListeners();
  }
}
