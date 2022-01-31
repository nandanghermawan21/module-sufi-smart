import 'package:flutter/material.dart';
import 'package:sufismart/util/system.dart';

class BasicComponent {
  static AppBar appBar() {
    return AppBar(
      backgroundColor: System.data.color!.mainColor,
      title: Image.asset(
        "assets/logo_sfi_white.png",
        fit: BoxFit.cover,
        height: 30,
      ),
    );
  }
}
