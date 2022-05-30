import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';

class KotaBranchModel {
  String? kodekota;
  String? namakota;

  KotaBranchModel({
    this.kodekota,
    this.namakota,
  });

  factory KotaBranchModel.fromJson(Map<String, dynamic> json) {
    return KotaBranchModel(
      kodekota: json["kota_kode"] as String?,
      namakota: json["kota_name"] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'kota_kode': kodekota,
        'kota_name': namakota,
      };

  static Future<List<KotaBranchModel>> getListKotaBranch() {
    ModeUtil.debugPrint("call get list kota api");
    return http
        .get(Uri.parse(System.data.apiEndPoint.getListAllBranch()))
        .then((value) {
      ModeUtil.debugPrint("call get list kota api 2");
      if (value.statusCode == 200) {
        var response = json.decode(value.body);

        ModeUtil.debugPrint("call get list kota api 4 + ${response["data"]}");
        ModeUtil.debugPrint("call get list kota api 3 ${value.body}");

        if (response["isSuccess"] == true) {
          return (response["data"] as List)
              .map((e) => KotaBranchModel.fromJson(e))
              .toList();
        } else {
          ModeUtil.debugPrint("error parsing data list Kota");
          throw Exception('Failed to list Kota');
        }
      } else {
        ModeUtil.debugPrint("error not status Code 200->");
        throw value;
      }
    }).catchError((onError) {
      ModeUtil.debugPrint("masuk on error " + onError.toString());
      throw onError;
    });
  }
}
