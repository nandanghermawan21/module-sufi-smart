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

  ValueChanged<OSNotificationReceivedEvent>?
      notificationWillShowInForegroundHandler;

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

    OneSignal.shared.setRequiresUserPrivacyConsent(true);

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      if (notificationClickedHandler != null) {
        notificationOpenedHandler!(result);
      }
    });

    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      /// Display Notification, send null to not display
      if (notificationWillShowInForegroundHandler != null) {
        notificationWillShowInForegroundHandler!(event);
      }
      event.complete(null);
    });

    OneSignal.shared
        .setInAppMessageClickedHandler((OSInAppMessageAction action) {
      if (notificationClickedHandler != null) {
        notificationClickedHandler!(action);
      }
    });

    OneSignal.shared
        .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
      if (subscriptionChangeHandler != null) {
        return subscriptionChangeHandler!(changes);
      }
    });

    OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
      if (permissionStateChangeHandler != null) {
        permissionStateChangeHandler!(changes);
      }
    });

    // NOTE: Replace with your own app ID from https://www.onesignal.com
    await OneSignal.shared.setAppId(appId ?? "");

    await OneSignal().consentGranted(true);

    await OneSignal.shared.requiresUserPrivacyConsent();

    OneSignal.shared.disablePush(false);

    await OneSignal.shared.userProvidedPrivacyConsent();
  }

  Future<String?> getTokenId() async {
    final status = await OneSignal.shared.getDeviceState();
    final String? osUserId = status?.userId;
    return osUserId;
  }
}
