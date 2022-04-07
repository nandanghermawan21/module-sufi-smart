import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sufismart/model/position_model.dart';
import 'package:sufismart/util/enum.dart';
import 'package:sufismart/util/error_handling_util.dart';
import 'package:sufismart/util/system.dart';

void onServiceStarted() {
  debugPrint("onServiceStarted called");
  System.data.service
      .sendData({ServiceKey.action: ServiceValueAction.sendPosition});
}

void onEvent(Map<String, dynamic>? event) {
  if (event == null) return;
  switch (event[ServiceKey.action]) {
    case ServiceValueAction.sendPosition:
      saveLocation();
      break;
    default:
  }
}

void saveLocation() {
  debugPrint("send position ${System.data.global.customerModel?.id}");
  if (System.data.global.customerModel?.id != null) {
    Permission.location.isGranted.then(
      (grandted) {
        if (grandted == true) {
          debugPrint("read location");
          Geolocator.getCurrentPosition().then(
            (value) {
              PositionModel.save(
                positionModel: PositionModel(
                  id: 0,
                  createDate: value.timestamp?.toUtc(),
                  ref: "TESTFROMAPP",
                  lat: value.latitude,
                  lon: value.longitude,
                  direction: value.heading,
                ),
              ).then((position) {
                debugPrint("send success");
                Future.delayed(const Duration(seconds: 1)).then((value) =>
                    System.data.service.sendData(
                        {ServiceKey.action: ServiceValueAction.sendPosition}));
              }).catchError((onError) {
                debugPrint(
                    "send error ${ErrorHandlingUtil.handleApiError(onError)}");
                Future.delayed(const Duration(seconds: 1)).then((value) =>
                    System.data.service.sendData(
                        {ServiceKey.action: ServiceValueAction.sendPosition}));
              });
            },
          );
        } else {
          Future.delayed(const Duration(seconds: 1)).then((value) => System
              .data.service
              .sendData({ServiceKey.action: ServiceValueAction.sendPosition}));
        }
      },
    );
  } else {
    debugPrint("send position cancel userid null ");
    Future.delayed(const Duration(seconds: 1)).then((value) => System
        .data.service
        .sendData({ServiceKey.action: ServiceValueAction.sendPosition}));
  }
}
