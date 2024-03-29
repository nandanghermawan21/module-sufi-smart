import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sufismart/model/customer_model.dart';
import 'package:sufismart/model/news_model.dart';
import 'package:sufismart/model/notifications_model.dart';
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
  ];
  //setting oneSignal notification
  System.data.oneSignalMessaging = OneSignalMessaging(
    appId: "5950883a-0066-4be7-ac84-3d240982ffaf",
    notificationHandler: (notification) {
      ModeUtil.debugPrint("notification notificationHandler fire");
      NotificationModel(
        appId: System.data.global.notifAppId,
        apiKey: System.data.global.notifAppKey,
      ).handleNotif(notification.additionalData ?? {});
    },
    notificationOpenedHandler: (notification) {
      ModeUtil.debugPrint("notification notificationOpenedHandler fire");
    },
    notificationClickedHandler: (notification) {
      ModeUtil.debugPrint("notification notificationClickedHandler fire");
    },
  );
  //subscribe chanel
  System.data.oneSignalMessaging!.sendTag("specialUser", true);
  System.data.deepLinkingHandler = (uri) {
    ModeUtil.debugPrint(uri?.path ?? "");
    if (ModalRoute.of(System.data.context)?.settings.name == initialRouteName) {
      return;
    }
    switch (uri?.path) {
      case "/allNews":
        Navigator.of(System.data.context).pushNamed(RouteName.allNews);
        break;
      case "/news":
        NewsModel _news = NewsModel.dummy()
            .where((e) =>
                e.newsid == int.parse((uri?.queryParameters["id"] as String)))
            .first;
        Navigator.of(System.data.context).pushNamed(
          RouteName.detailNews,
          arguments: {
            ParamName.newsModel: _news,
          },
        );
        break;
      case "/chat":
        String? id = (uri?.queryParameters["sender"] as String);
        CustomerModel.getInfo(
          id: id,
        ).then((customer) {
          Navigator.of(System.data.context)
              .pushNamed(RouteName.chat, arguments: {
            ParamName.customerModel: customer,
          });
        });
        break;
      default:
        return;
    }
  };
  System.data.onCreateDb = (db, version) {
    int _last = 6;
    for (int i = version; i < _last; i++) {
      rootBundle.loadString("dbmigration/dbv${i + 1}.sql").then((sql) {
        db?.execute(sql).then((v) {
          db.setVersion(i + 1).then((v) {
            ModeUtil.debugPrint("update to version ${i + 1}");
          });
        });
      });
      ModeUtil.debugPrint("update is uptodate");
    }
  };
}
