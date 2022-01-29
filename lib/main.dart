import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sufismart/setting.dart';
import 'package:sufismart/util/data.dart';
import 'package:sufismart/recource/strings.dart';
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/route.dart';

Data data = Data();
void main() {
  setting();
  getOneSignalToken()?.then((value) {
    runApp(const MyApp());
  });
}

Future<void>? getOneSignalToken({int trial = 0}) {
  return System.data.oneSignalMessaging?.initOneSignal().then((onValue) async {
    System.data.oneSignalMessaging?.getTokenId().then(
      (token) {
        System.data.global.mmassagingToken = token;
        ModeUtil.debugPrint(
            "OneSignalMessagingToken trial to ${trial + 1} ${System.data.global.mmassagingToken}");
        if (System.data.global.mmassagingToken == null) {
          getOneSignalToken(
            trial: trial + 1,
          );
        }
      },
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: System.data,
      child: Consumer<Data>(
        builder: (c, d, w) {
          return MaterialApp(
            title: Strings.appName,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            routes: route,
            initialRoute: RouteName.home,
          );
        },
      ),
    );
  }
}
