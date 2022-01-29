import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sufismart/recource/color_ui.dart';
import 'package:sufismart/view_model/background_service_view_model.dart';

class BackgroundService extends StatefulWidget {
  const BackgroundService({
    Key? key,
  }) : super(key: key);

  @override
  BackgroundServiceState createState() => BackgroundServiceState();
}

class BackgroundServiceState extends State<BackgroundService> {
  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) {
      androidAppRetain.invokeMethod("wasActivityKilled").then((result) {
        if (result) {
          showDialog(
              context: context,
              builder: (context) {
                // return ActivityGotKilledDialog();
                return Container();
              });
        }
      });
    }
  }

  BackgroundServiceViewModel model = BackgroundServiceViewModel();

  var androidAppRetain = const MethodChannel("android_app_retain");

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: model,
      child: Consumer<BackgroundServiceViewModel>(
        builder: (BuildContext context, vm, Widget? child) {
          return Scaffold(
            appBar: appBar(vm),
            backgroundColor: ColorUi.background,
            body: Container(),
          );
        },
      ),
    );
  }

  AppBar appBar(BackgroundServiceViewModel vm) {
    return AppBar(
      backgroundColor: ColorUi.mainColor,
      title: Image.asset(
        "assets/logo_sfi_white.png",
        fit: BoxFit.cover,
        height: 30,
      ),
    );
  }
}
