import 'dart:convert';

import 'package:sufismart/model/popup_model.dart';
import 'package:sufismart/util/mode_util.dart';

class NotificationModel {
  String? appid;

  NotificationModel({
    this.appid,
  });

  Future<void> handleNotif(Map<String,dynamic> data) async{

    Map<String, dynamic> notifData = json.decode(json.encode(data));
    PopupModel popupmodel = PopupModel.fromJson(notifData);
    ModeUtil.debugPrint("call get popup ${popupmodel.title}");
  }
}
