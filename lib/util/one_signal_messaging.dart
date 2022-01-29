import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalMessaging {
  String? appId = "ac7a2d3b-9c11-4ead-b50c-a8c6b6a13a81";
  Map<OSiOSSettings, dynamic> settings = {
    OSiOSSettings.autoPrompt: false,
    OSiOSSettings.promptBeforeOpeningPushUrl: true
  };
  ValueChanged<OSNotification>? notificationHandler;

  ValueChanged<OSNotificationOpenedResult>? notificationOpenedHandler;

  ValueChanged<OSInAppMessageAction>? notificationClickedHandler;

  OneSignalMessaging({
    this.appId,
    this.notificationClickedHandler,
    this.notificationHandler,
    this.notificationOpenedHandler,
  });

  Future<void> initOneSignal() async {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    OneSignal.shared.setRequiresUserPrivacyConsent(false);
    // OneSignal.shared
    //     .setInFocusDisplayType(OSNotificationDisplayType.notification);

    // if (notificationHandler != null) {
    //   OneSignal.shared.setNotificationReceivedHandler(
    //     (OSNotification notification) {
    //       notificationHandler(notification);
    //     },
    //   );
    // }

    if (notificationHandler != null) {
      OneSignal.shared.setNotificationWillShowInForegroundHandler((event) {
        notificationHandler!((event.notification));
      });
    }

    if (notificationOpenedHandler != null) {
      OneSignal.shared
          .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
        notificationOpenedHandler!(result);
      });
    }

    OneSignal.shared
        .setInAppMessageClickedHandler((OSInAppMessageAction action) {});
    await OneSignal.shared.setAppId(appId ?? "");
    // await OneSignal.shared.init("${this.appId}", iOSSettings: settings);
    // OneSignal.shared
    //     .setInFocusDisplayType(OSNotificationDisplayType.notification);
    OneSignal.shared.consentGranted(true);
  }

  Future<String> getTokenId() async {
    var status = await OneSignal.shared.getDeviceState();
    var playerId = status!.userId;
    return playerId!;
  }
}
