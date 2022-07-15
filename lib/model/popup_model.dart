import 'dart:convert';

import 'package:sufismart/util/mode_util.dart';
import 'package:http/http.dart' as http;
import 'package:sufismart/util/system.dart';

class PopupModel {
  final String? title;
  final String? content;
  final String? image;
  final String? nokonktrak;
  final String? id;
  final String? tipe;

  PopupModel({
    this.title,
    this.content,
    this.image,
    this.nokonktrak,
    this.id,
    this.tipe,
  });

  factory PopupModel.fromJson(Map<String, dynamic> json) {
    return PopupModel(
      title: json["title"] as String?,
      content: json["content"] as String?,
      image: json["image"] as String?,
      nokonktrak: json["nokonktrak"] as String?,
      id: json["id"] as String?,
      tipe: json["tipe"] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "content": content,
      "image": image,
      "nokonktrak": nokonktrak,
      "id": id,
      "tipe": tipe,
    };
  }

  static Future<PopupModel?> getDataNotifByid({
    required String? id,
  }){
    ModeUtil.debugPrint("call get notif api by id");
    return http.get(Uri.parse(System.data.apiEndPoint.getDataNotif(id: id))).then((value){
      if(value.statusCode == 200){
        ModeUtil.debugPrint("call get notif new api ${value.body}");
        return PopupModel.fromJson(json.decode(value.body));
      }else{
        ModeUtil.debugPrint("error not status code 200");
        throw value;
      }
    }).catchError((onError){
      throw onError;
    });
  }
}
