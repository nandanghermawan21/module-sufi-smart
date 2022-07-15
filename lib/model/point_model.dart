import 'dart:convert';

import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';
import 'package:http/http.dart' as http;

class PointModel {
  String? point;
  String? leveluser;
  String? tipe;
  String? idkomunitas;

  PointModel({
    this.point,
    this.leveluser,
    this.tipe,
    this.idkomunitas,
  });

  factory PointModel.fromJson(Map<String, dynamic> json) {
    return PointModel(
      point: json["point"] as String?,
      leveluser: json["leveluser"] as String?,
      tipe: json["tipe"] as String?,
      idkomunitas: json["idkomunitas"] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "point": point,
      "leveluser": leveluser,
      "tipe": tipe,
      "idkomunitas": idkomunitas,
    };
  }

  static Future<PointModel?> getPointUser({
    required String? id,
  }) {
    ModeUtil.debugPrint("call get list news api by id");
    return http
        .get(Uri.parse(System.data.apiEndPoint.getPointUserId(id: id)))
        .then((value) {
      if (value.statusCode == 200) {
        ModeUtil.debugPrint("call get point new api ${value.body}");
        return PointModel.fromJson(json.decode(value.body));
      } else {
        ModeUtil.debugPrint("error not status code 200 get Point Id");
        throw value;
      }
    }).catchError((onError) {
      throw onError;
    });
  }
}
