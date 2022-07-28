import 'dart:convert';

import 'package:sufismart/util/system.dart';

import '../util/mode_util.dart';
import 'package:http/http.dart' as http;

class MerchantModel {
  String? merchantid;
  String? namaproduk;
  String? point;
  String? img;
  String? nominalpoint;
  String? claim;

  MerchantModel({
    this.merchantid,
    this.namaproduk,
    this.point,
    this.img,
    this.nominalpoint,
    this.claim,
  });

  factory MerchantModel.fromJson(Map<String, dynamic> json) {
    return MerchantModel(
      merchantid: json["merchantid"] as String,
      namaproduk: json["namaproduk"] as String,
      point: json["point"] as String,
      img: json["img"] as String,
      nominalpoint: json["nominalpoint"] as String,
      claim: json["claim"] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "merchantid": merchantid,
      "namaproduk": namaproduk,
      "point": point,
      "img": img,
      "nominalpoint": nominalpoint,
      "claim": claim,
    };
  }

  static Future<List<MerchantModel>?> getListMerchant({
    required String? userid,
  }) {
    ModeUtil.debugPrint("call get merchant Api");
    return http
        .get(Uri.parse(System.data.apiEndPoint.getMerchant(userid: userid)))
        .then((value) {
      if (value.statusCode == 200) {
        return (json.decode(value.body) as List)
            .map((e) => MerchantModel.fromJson(e))
            .toList();
      } else {
        throw value;
      }
    }).catchError((onError) {
      ModeUtil.debugPrint("on error get merchant Api " + onError);
      throw onError;
    });
  }
}
