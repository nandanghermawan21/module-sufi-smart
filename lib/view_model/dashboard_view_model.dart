import 'package:flutter/material.dart';
import 'package:flutter_locker/flutter_locker.dart';
import 'package:random_string/random_string.dart';
import 'package:sufismart/util/enum.dart';
import 'package:sufismart/util/error_handling_util.dart';
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';

class DashboardViewModel extends ChangeNotifier {
  bool canAuthenticate = false;
  String lockStatus = LockStatus.unRegister;

  void commit() {
    notifyListeners();
  }

  void checkAuthenticate() {
    FlutterLocker.canAuthenticate().then((value) {
      canAuthenticate = value ?? false;
      lockStatus = System.data.session!.getString(SessionKey.lockStatus) ??
          LockStatus.unRegister;
      commit();
    }).catchError((onError) {
      ModeUtil.debugPrint(ErrorHandlingUtil.readMessage(onError));
    });
  }

  void registerAuth() {
    String _key = randomAlphaNumeric(10);
    String _secret = randomAlphaNumeric(10);

    FlutterLocker.save(
      SaveSecretRequest(
          _key,
          _secret,
          AndroidPrompt(
            System.data.strings!.registerYourBiometric,
            System.data.strings!.cancel,
          )),
    ).then((value) async {
      lockStatus = LockStatus.opened;
      await System.data.session!.setString(SessionKey.lockhKey, _key);
      await System.data.session!.setString(SessionKey.lockSecret, _secret);
      await System.data.session!.setString(SessionKey.lockStatus, lockStatus);
      commit();
    }).catchError((onError) {
      ModeUtil.debugPrint(ErrorHandlingUtil.readMessage(onError));
    });
  }

  Future<bool> autenticate() {
    return FlutterLocker.retrieve(
      RetrieveSecretRequest(
        System.data.session!.getString(SessionKey.lockhKey) ?? "",
        AndroidPrompt('Authenticate', System.data.strings!.cancel),
        IOsPrompt('Authenticate'),
      ),
    ).then(
      (value) {
        if (value ==
            (System.data.session!.getString(SessionKey.lockSecret) ?? "")) {
          return true;
        } else {
          return false;
        }
      },
    ).catchError((onError) {
      ModeUtil.debugPrint(onError);
    });
  }

  void setToLock() {
    autenticate().then((value) {
      if (value == true) {
        lockStatus = LockStatus.locked;
        System.data.session!.setString(SessionKey.lockStatus, lockStatus);
        commit();
      }
    });
  }

  void setToOpen() {
    autenticate().then((value) {
      if (value == true) {
        lockStatus = LockStatus.opened;
        System.data.session!.setString(SessionKey.lockStatus, lockStatus);
        commit();
      }
    });
  }

  void lockDashboard() {
    debugPrint("lock status $lockStatus");
    switch (lockStatus) {
      case LockStatus.unRegister:
        registerAuth();
        break;
      case LockStatus.opened:
        setToLock();
        break;
      case LockStatus.locked:
        setToOpen();
        break;
      default:
    }
  }
}
