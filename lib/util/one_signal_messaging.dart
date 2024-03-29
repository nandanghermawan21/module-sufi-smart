import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:sufismart/util/mode_util.dart';

class OneSignalMessaging {
  String? appId = "ac7a2d3b-9c11-4ead-b50c-a8c6b6a13a81";
  Map<OSiOSSettings, dynamic> settings = {
    OSiOSSettings.autoPrompt: false,
    OSiOSSettings.promptBeforeOpeningPushUrl: true
  };
  ValueChanged<OSNotification>? notificationHandler;

  ValueChanged<OSNotificationOpenedResult>? notificationOpenedHandler;

  ValueChanged<OSInAppMessageAction>? notificationClickedHandler;

  ValueChanged<OSSubscriptionStateChanges>? subscriptionChangeHandler;

  ValueChanged<OSPermissionStateChanges>? permissionStateChangeHandler;

  OneSignalMessaging({
    this.appId,
    this.notificationClickedHandler,
    this.notificationHandler,
    this.notificationOpenedHandler,
  });

  Future<void> initOneSignal() async {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    OneSignal.shared.setRequiresUserPrivacyConsent(false);

    if (notificationHandler != null) {
      OneSignal.shared.setNotificationWillShowInForegroundHandler((event) {
        ModeUtil.debugPrint(
            "setNotificationWillShowInForegroundHandler ${event.notification.badge}");
        event.complete(event.notification);
        notificationHandler!((event.notification));
      });
    }

    if (notificationOpenedHandler != null) {
      OneSignal.shared
          .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
        ModeUtil.debugPrint(
            "setNotificationWillShowInForegroundHandler ${result.notification.badge}");
        notificationOpenedHandler!(result);
      });
    }

    OneSignal.shared
        .setInAppMessageClickedHandler((OSInAppMessageAction action) {});
    ModeUtil.debugPrint("init one signal with appid $appId}");
    await OneSignal.shared.setAppId("$appId");
    OneSignal.shared.consentGranted(true);
  }

  Future<Map<String, dynamic>> getAllTag() {
    return OneSignal.shared.getTags();
  }

  Future<Map<String, dynamic>> sendTag(String key, dynamic value) {
    return OneSignal.shared.sendTag(key, value);
  }

  Future<Map<String, dynamic>> deleteTag(String key) {
    return OneSignal.shared.deleteTag(key);
  }

  Future<String?> getTokenId() async {
    final status = await OneSignal.shared.getDeviceState();
    final String? osUserId = status?.userId;
    return osUserId;
  }
}
