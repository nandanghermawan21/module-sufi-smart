import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sufismart/setting.dart';
import 'package:sufismart/util/data.dart';
import 'package:sufismart/recource/strings.dart';
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/route.dart';

Data data = Data();
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setting();
  runApp(const MyApp());
}

Future<void> getPermission() async {
  for (var permition in System.data.permission) {
    await permition.request().then((value) {
      ModeUtil.debugPrint("${permition.toString()} grandted");
    }).catchError((onError) {
      ModeUtil.debugPrint(onError);
    });
  }
}

void initOnesignal() {
  System.data.oneSignalMessaging?.initOneSignal().then((onValue) async {
    getDeviceId();
  });
}

void getDeviceId({int trial = 0}) {
  System.data.oneSignalMessaging?.getTokenId().then(
    (token) {
      System.data.global.mmassagingToken = token;
      ModeUtil.debugPrint(
          "OneSignalMessagingToken trial to ${trial + 1} ${System.data.global.mmassagingToken}");
      if (System.data.global.mmassagingToken == null) {
        getDeviceId(
          trial: trial + 1,
        );
      }
    },
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    if (!mounted) return;
    getPermission().then((value) {
      initOnesignal();
    });
  }

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
