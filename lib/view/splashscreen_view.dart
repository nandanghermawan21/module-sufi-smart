import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sufismart/model/customernew_model.dart';
import 'package:sufismart/util/enum.dart';
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';

class SplashScreenView extends StatefulWidget {
  final VoidCallback? onFinish;
  const SplashScreenView({
    Key? key,
    this.onFinish,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SplashScreenViewState();
  }
}

class _SplashScreenViewState extends State<SplashScreenView> {
  void startLaunching() {
    var duration = const Duration(seconds: 3);
    Timer(duration, () {
      widget.onFinish!();
    });
  }

  void readSessions() {
    if (System.data.session!.getString(SessionKey.user) == "") {
      startLaunching();
    } else {
      System.data.global.customerNewModel =
          CustomerNewModel.fromJson(json.decode(
        System.data.session!.getString(SessionKey.user) ?? "{}",
      ));
      System.data.global.token = System.data.global.customerNewModel?.deviceid;
      ModeUtil.debugPrint(
          "Curent Customer ${System.data.global.customerNewModel?.toJson()}");
      ModeUtil.debugPrint("start save user position");
      startLaunching();
    }
    //startLaunching();
  }

  @override
  void initState() {
    super.initState();
    readSessions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/splashscreen.png",
          height: 150.0,
          width: 250.0,
        ),
      ),
      bottomNavigationBar: botimage(),
    );
  }

  Widget botimage() {
    return Container(
      margin: const EdgeInsets.all(15),
      color: Colors.transparent,
      height: 50,
      child: Center(
        child: Image.asset(
          "assets/ojk1.png",
          height: 150.0,
          width: 250.0,
        ),
      ),
    );
  }
}
