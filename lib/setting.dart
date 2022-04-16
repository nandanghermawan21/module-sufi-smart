import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sufismart/model/news_model.dart';
import 'package:sufismart/recource/color_default.dart';
import 'package:sufismart/recource/string_id_id.dart';
import 'package:sufismart/route.dart';
import 'package:sufismart/util/api_end_point.dart';
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/one_signal_messaging.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/util/databases.dart';

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
      ModeUtil.debugPrint("notification handler fire");
    },
    notificationOpenedHandler: (notification) {
      ModeUtil.debugPrint("notification opened fire");
    },
    notificationClickedHandler: (notification) {
      ModeUtil.debugPrint("notification handler fire");
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
      default:
        return;
    }
  };
  System.data.onCreateDb = (db, version) {
    int _last = 3;
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
    // switch (version) {
    //   case 0:
    //     rootBundle.loadString("dbmigration/dbmaster.sql").then((sql) {
    //       db?.execute(sql).then((v) {
    //         db.setVersion(1).then((v) {
    //           ModeUtil.debugPrint("update to databaase 1");
    //         });
    //       }).catchError((onError) {
    //         ModeUtil.debugPrint("error init db");
    //         ModeUtil.debugPrint(onError);
    //       });
    //     });
    //     break;
    //   case 1:
    //     rootBundle.loadString("dbmigration/updatedbv1.sql").then((sql) {
    //       db?.execute(sql).then((v) {
    //         db.setVersion(2).then((v) {
    //           ModeUtil.debugPrint("update v1 to master");
    //         });
    //       }).catchError((onError) {
    //         ModeUtil.debugPrint("error update v1");
    //         ModeUtil.debugPrint(onError);
    //       });
    //     });
    //     break;
    //   case 2:
    //     ModeUtil.debugPrint("database is uptodate");
    //     break;
    //   default:
    //     System.data.reInitDatabase();
    // }
  };
}
