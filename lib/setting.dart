import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sufismart/model/notification_model.dart';
import 'package:sufismart/recource/color_default.dart';
import 'package:sufismart/recource/string_id_id.dart';
import 'package:sufismart/route.dart';
import 'package:sufismart/util/api_end_point.dart';
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/one_signal_messaging.dart';
import 'package:sufismart/util/system.dart';

void setting() {
  System.data.apiEndPoint = ApiEndPoint();
  System.data.strings = StringsIdId();
  System.data.color = ColorDefault();
  //setting permisson [haru didefinisikan juga pada manifest dan info.pls]
  System.data.permission = [
    Permission.accessNotificationPolicy,
    Permission.location,
    Permission.phone,
    Permission.camera,
    Permission.storage,
  ];
  //setting oneSignal notification
  System.data.oneSignalMessaging = OneSignalMessaging(
    //appId: "8857c98d-aba9-45c2-abd8-692ad94f9521",
    appId: System.data.global.notifAppId,
    notificationHandler: (notification) {
      //System.data.showmodal();
      ModeUtil.debugPrint("notification handler fire");

      NotificationModel(
        appid: System.data.global.notifAppId,
      ).handleNotif(notification.additionalData ?? {});

      ModeUtil.debugPrint(
          "notification additional data ${notification.additionalData}");
    },
    notificationOpenedHandler: (notification) {
      ModeUtil.debugPrint("notification opened fire");
    },
    notificationClickedHandler: (notification) {
      ModeUtil.debugPrint("notification handler fire");
    },
  );
  //subscribe chanel
  System.data.oneSignalMessaging!.sendTag("userSmart", true);
  System.data.deepLinkingHandler = (uri) {
    ModeUtil.debugPrint(uri?.path ?? "");
    if (ModalRoute.of(System.data.context)?.settings.name == initialRouteName) {
      return;
    }
    switch (uri?.path) {
      case "/allNews":
        Navigator.of(System.data.context).pushNamed(RouteName.allNews);
        break;
      // case "/news":
      //   NewsModel _news = NewsModel.dummy()
      //       .where((e) =>
      //           e.newsid == int.parse((uri?.queryParameters["id"] as String)))
      //       .first;
      //   Navigator.of(System.data.context).pushNamed(
      //     RouteName.detailNews,
      //     arguments: {
      //       ParamName.newsModel: _news,
      //     },
      //   );
      //   break;
      case "/news":
        String? id = (uri?.queryParameters["id"]);
        // NewsModel _news = NewsModel.dummy()
        //     .where((e) =>
        //         e.newsid == int.parse((uri?.queryParameters["id"] as String)))
        //     .first;
        Navigator.of(System.data.context).pushNamed(
          RouteName.detailNewsDeepLink,
          arguments: {
            ParamName.newsdetailid: id,
          },
        );
        break;
      case "/notif":
        String? id = (uri?.queryParameters["id"]);
        Navigator.of(System.data.context).pushNamed(
          RouteName.announcementView,
          arguments: {
            ParamName.notifid: id,
          },
        );
        break;
      default:
        return;
    }
  };
}
