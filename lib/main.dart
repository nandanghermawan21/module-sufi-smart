import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sufismart/component/circular_loader_component.dart';
import 'package:sufismart/setting.dart';
import 'package:sufismart/util/data.dart';
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/route.dart';
import 'package:uni_links/uni_links.dart';
import 'route.dart';

Data data = Data();
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setting();
  data.initialize().then((val) {
    runApp(const MyApp());
  });
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
      System.data.global.messagingToken = token;
      ModeUtil.debugPrint(
          "OneSignalMessagingToken trial to ${trial + 1} ${System.data.global.messagingToken}");
      if (System.data.global.messagingToken == null) {
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
  bool _initialUriIsHandled = false;

  @override
  void initState() {
    super.initState();
    if (!mounted) return;
    handleInitialDeepLink();
    handleDeeplink();
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
            home: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              body: CircularLoaderComponent(
                controller: data.loadingController,
                child: home(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget home() {
    return MaterialApp(
      title: System.data.strings!.appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: route,
      initialRoute: initialRouteName,
      navigatorKey: System.data.navigatorKey,
    );
  }

  Future<void> handleInitialDeepLink() async {
    if (!_initialUriIsHandled) {
      _initialUriIsHandled = true;
      try {
        final uri = await getInitialUri();
        if (uri == null) {
          System.data.global.currentDeepLinkUri = uri;
        } else {
          System.data.global.currentDeepLinkUri = uri;
        }
        if (!mounted) return;
        if (System.data.deepLinkingHandler != null) {
          System.data.deepLinkingHandler!(uri);
        }
      } on PlatformException {
        ModeUtil.debugPrint('falied to get initial uri');
      } on FormatException catch (err) {
        if (!mounted) return;
        ModeUtil.debugPrint(err);
        System.data.global.currentDeepLinkUri = null;
      }
    }
  }

  void handleDeeplink() {
    if (!kIsWeb) {
      // It will handle app links while the app is already started - be it in
      // the foreground or in the background.
      uriLinkStream.listen(
        (uri) {
          if (!mounted) return;
          ModeUtil.debugPrint(uri?.path ?? "");
          System.data.global.currentDeepLinkUri = uri;
          if (System.data.deepLinkingHandler != null) {
            System.data.deepLinkingHandler!(uri);
          }
        },
        onError: (Object err) {
          if (!mounted) return;
        },
      );
    }
  }
}
