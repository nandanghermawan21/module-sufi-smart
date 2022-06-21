import 'dart:async';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sufismart/util/api_end_point.dart';
import 'package:sufismart/util/colour.dart';
import 'package:sufismart/util/databases.dart';
import 'package:sufismart/util/strings.dart';
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/one_signal_messaging.dart';
import 'package:sufismart/component/circular_loader_component.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:sufismart/util/system.dart';

import 'global.dart';

class Data extends ChangeNotifier {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  CircularLoaderController loadingController = CircularLoaderController();
  BuildContext get context => navigatorKey.currentContext!;
  ApiEndPoint apiEndPoint = ApiEndPoint();
  Global global = Global();
  Strings? strings;
  Colour? color;
  OneSignalMessaging? oneSignalMessaging;
  List<Permission> permission = [];
  ValueChanged<Uri?>? deepLinkingHandler;
  SharedPreferences? session;
  Databases? database;
  Function(Database?, int)? onCreateDb;
  ValueChanged<Map<String, dynamic>?>? onServiceDataReceived;
  FlutterBackgroundService service = FlutterBackgroundService();

  Data();

  Future<void> initialize() async {
    await _initSharedPreference();
    await _initDatabse();
  }

  void commit() {
    notifyListeners();
  }

  Future<bool> _initSharedPreference() async {
    session = await SharedPreferences.getInstance();
    return true;
  }

  Future<bool> _initDatabse() async {
    database = await Databases().initializeDb(
      onCreate: (db, version) {
        ModeUtil.debugPrint("Database information :");
        ModeUtil.debugPrint("path                 : ${db?.path}");
        ModeUtil.debugPrint("version              : $version");
        if (onCreateDb != null) {
          onCreateDb!(db, version);
        }
      },
    );
    return true;
  }

  void showmodal() {
    showDialog(
      context: System.data.context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(""), // To display the title it is optional
        // content: Text(
        //   System.data.strings!.infoLogout,
        // ), // Message which will be pop up on the screen
        content: (SingleChildScrollView(
            child: Container(
          color: Colors.transparent,
          child: Column(
            children: const [
              Text(
                "Announcement",
                style: TextStyle(
                    color: Color(0xff0d306b),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ))),
        // Action widget which will provide the user to acknowledge the choice
        actions: [
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(System.data.color!.primaryColor)),
            onPressed: () {
              Navigator.pop(context);
            }, // function used to perform after pressing the button
            child: const Text('No'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              //widget.goTologout!();
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}
