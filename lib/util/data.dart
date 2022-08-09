import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sufismart/route.dart';
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

  void showmodal(String? strContent, String? strTitle) {
    showDialog(
      context: System.data.context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          strTitle!,
          style: const TextStyle(
            color: Color(0xff0d306b),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left,
        ), // To display the title it is optional
        // content: Text(
        //   System.data.strings!.infoLogout,
        // ), // Message which will be pop up on the screen
        content: (SingleChildScrollView(
          child: Container(
            color: Colors.transparent,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  strContent!,
                  //textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        )),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              //widget.goTologout!();
            },
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }

  void popupModalImage(String? img, String? strid, String? strTitle) {
    showDialog(
      context: System.data.context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Colors.transparent,
        title: Text(
          strTitle!,
          style: TextStyle(
            color: System.data.color!.whiteColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ), // To display the title it is optional
        // content: Text(
        //   System.data.strings!.infoLogout,
        // ), // Message which will be pop up on the screen
        content: (SingleChildScrollView(
          child: Container(
            color: Colors.transparent,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                // Text(
                //   strContent!,
                //   textAlign: TextAlign.justify,
                // ),
                CachedNetworkImage(
                  imageUrl: img ?? "",
                  imageBuilder: (context, imageProvider) => Container(
                    // height: MediaQuery.of(context).size.height * 250,
                    // width: MediaQuery.of(context).size.width * 300 ,
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.only(
                      //     bottomLeft: Radius.circular(15),
                      //     bottomRight: Radius.circular(15)),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.fill),
                    ),
                  ),
                  placeholder: (context, url) => SkeletonAnimation(
                      child: Container(
                    //height: MediaQuery.of(context).size.height / 3.5,
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                      color: System.data.color!.greyColor2,
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      // borderRadius: const BorderRadius.only(
                      //     bottomLeft: Radius.circular(15),
                      //     bottomRight: Radius.circular(15)),
                    ),
                  )),
                  errorWidget: (context, url, error) => Container(
                    //height: MediaQuery.of(context).size.height / 3.5,
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                      color: System.data.color!.greyColor2,
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      // borderRadius: const BorderRadius.only(
                      //     bottomLeft: Radius.circular(15),
                      //     bottomRight: Radius.circular(15))
                      // borderRadius: BorderRadius.all(
                      //     Radius.circular(10))
                      //,
                    ),
                    child: const Center(
                      child: Icon(Icons.error),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(System.data.context).pushNamed(
                RouteName.detailNewsDeepLink,
                arguments: {
                  ParamName.newsdetailid: strid,
                },
              );
              //widget.goTologout!();
            },
            child: Text(
              System.data.strings!.seepromo,
            ),
          ),
        ],
      ),
    );
  }
}
