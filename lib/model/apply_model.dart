import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';

class ApplyModel {
  final String? applyid; //"1",
  final String? userid; //"3418",
  final String? trxno; //"SUFI-202206060001",
  final String? stat; //"ON PROGRESS",
  final String? produk; //"XL7",
  final String? model; //"XL7 BETA AT",
  final String? orderno; //"3220608001",
  final String? tanggalorder; //"2022-06-06",
  final String? viewdetail;

  ApplyModel({
    this.applyid,
    this.userid,
    this.trxno,
    this.stat,
    this.produk,
    this.model,
    this.orderno,
    this.tanggalorder,
    this.viewdetail,
  });

  factory ApplyModel.fromJson(Map<String, dynamic> json) {
    return ApplyModel(
      applyid: json["applyid"] as String,
      userid: json["userid"] as String,
      trxno: json["trxno"] as String,
      stat: json["stat"] as String,
      produk: json["produk"] as String,
      model: json["model"] as String,
      orderno: json["orderno"] as String,
      tanggalorder: json["tanggalorder"] as String,
      viewdetail: json["viewdetail"] as String,
    );
  }

  toJson(Map<String, dynamic> toJson) {
    return {
      'applyid': applyid,
      'userid': userid,
      'trxno': trxno,
      'stat': stat,
      'produk': produk,
      'model': model,
      'orderno': orderno,
      'tanggalorder': tanggalorder,
      'viewdetail': viewdetail,
    };
  }

  static Future<List<ApplyModel>?> getListApplyUser({
    required String? userid,
  }) {
    ModeUtil.debugPrint("call get gender api");
    return http
        .get(
            Uri.parse(System.data.apiEndPoint.getDataApplyUser(userid: userid)))
        .then((value) {
      if (value.statusCode == 200) {
        ModeUtil.debugPrint("call get apply user api 1 ${value.body}");
        return (json.decode(value.body) as List)
            .map((e) => ApplyModel.fromJson(e))
            .toList();
      }
    }).catchError((onError) {
      ModeUtil.debugPrint("masuk on error " + onError.toString());
      throw onError;
    });
  }
}
