import 'package:sufismart/util/one_signal_messaging.dart';
import 'package:sufismart/util/system.dart';

void setting() {
  //setting oneSignal notification
  System.data.oneSignalMessaging = OneSignalMessaging(
    appId: "5950883a-0066-4be7-ac84-3d240982ffaf",
  );
}
