import 'package:flutter/material.dart';

class MenuModel {
  VoidCallback? ontap;
  String? title;
  String? image;
  IconData? iconData;

  MenuModel({
    this.ontap,
    this.image,
    this.iconData,
    this.title,
  });
}
