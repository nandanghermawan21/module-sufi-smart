import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';

class HistoryModel {
  String? userid;
  String? point;
  String? note;
  String? deskripsi;
  String? tipe;
  String? crtdate;

  HistoryModel({
    this.userid,
    this.point,
    this.note,
    this.deskripsi,
    this.tipe,
    this.crtdate,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      userid: json["userid"] as String,
      point: json["point"] as String,
      note: json["note"] as String,
      deskripsi: json["deskripsi"] as String,
      tipe: json["tipe"] as String,
      crtdate: json["crtdate"] as String,
    );
  }

  Map<String, dynamic> tojson() {
    return {
      "userid": userid,
      "point": point,
      "note": note,
      "deskripsi": deskripsi,
      "tipe": tipe,
      "crtdate": crtdate,
    };
  }

  static Future<List<HistoryModel>?> getHistoryPoint({
    required String? userid,
  }) {
    ModeUtil.debugPrint("call get history point Api");
    return http
        .get(Uri.parse(System.data.apiEndPoint.getHistoryPoint(userid: userid)))
        .then((value) {
      if (value.statusCode == 200) {
        return (json.decode(value.body) as List)
            .map((e) => HistoryModel.fromJson(e))
            .toList();
      }
    }).catchError((onError) {
      ModeUtil.debugPrint("on error get history Api " + onError);
      throw onError;
    });
  }
}
