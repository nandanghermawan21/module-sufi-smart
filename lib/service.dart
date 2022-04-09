import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sufismart/model/position_model.dart';
import 'package:sufismart/util/enum.dart';
import 'package:sufismart/util/error_handling_util.dart';
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';
void onServicestart(){

}

void restartService({VoidCallback? onRestarted}) {
  System.data.service.stopService();
  System.data.service.startService().then((value) {
    System.data.service.sendData(
      {
        ServiceKey.action: ServiceValueAction.sendPosition,
        Prefkey.userId: System.data.global.customerModel?.id,
      },
    );
    if (onRestarted != null) {
      onRestarted();
    }
  });
}
void onEvent(Map<String, dynamic>? event) {
  ModeUtil.debugPrint(event.toString());
  if (event == null) return;
  switch (event[ServiceKey.action]) {
    case ServiceValueAction.sendPosition:
      saveLocationUser(
        userId: event[Prefkey.userId],
      );
      break;
    case ServiceValueAction.sendToForeground:
      debugPrint("send to foreground");
      System.data.service.setAsForegroundService();
      break;
    default:
  }
}

void saveLocationUser({
  int? userId,
}) {
  debugPrint("send position user => UserId $userId");
  if (userId != null) {
    Permission.location.isGranted.then(
      (grandted) {
        if (grandted == true) {
          debugPrint("send position user => Stream Position");
          Geolocator.getPositionStream().listen((event) {
            debugPrint("send position user => Listen New Position");
            postLocation(
              value: event,
              userId: userId,
            );
          });
        } else {
          debugPrint(
              "send position user => send position cancel permission not granted ");
        }
      },
    );
  } else {
    debugPrint("send position user => cancel userid null ");
  }
}

void postLocation({
  required Position value,
  int? userId,
}) {
  PositionModel.save(
    positionModel: PositionModel(
      id: 0,
      createDate: value.timestamp?.toUtc(),
      ref: "CUSTPOS-$userId",
      lat: value.latitude,
      lon: value.longitude,
      direction: value.heading,
    ),
  ).then(
    (position) {
      debugPrint("send position user =>  $userId success");
    },
  ).catchError(
    (onError) {
      debugPrint(
          "end position user => error ${ErrorHandlingUtil.handleApiError(onError)}");
    },
  );
}