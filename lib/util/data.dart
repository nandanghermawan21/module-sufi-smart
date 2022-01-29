import 'package:flutter/material.dart';
import 'package:sufismart/util/one_signal_messaging.dart';

import 'global.dart';

class Data extends ChangeNotifier {
  Global global = Global();
  OneSignalMessaging? oneSignalMessaging;

  void commit() {
    notifyListeners();
  }
}
