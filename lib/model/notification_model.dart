import 'dart:convert';

import 'package:sufismart/model/popup_model.dart';
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';

class NotificationModel {
  String? appid;

  NotificationModel({
    this.appid,
  });

  Future<void> handleNotif(Map<String,dynamic>? data) async{

    Map<String, dynamic> notifData = json.decode(json.encode(data));
    PopupModel popupmodel = PopupModel.fromJson(notifData);
    ModeUtil.debugPrint("call get popup ${popupmodel.title}");
    String? content = popupmodel.content;    
    String? title = popupmodel.title; 
    String? key = popupmodel.tipe;
    String? img = popupmodel.image;
    String? id = popupmodel.id;

    if(key == "notif"){
      System.data.showmodal(content,title);
    }else if (key == "promo"){
      System.data.popupModalImage(img,id,title);
    }   
    
  }
}
