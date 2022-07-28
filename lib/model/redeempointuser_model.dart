import 'dart:convert';
import 'dart:io';

import 'package:sufismart/util/mode_util.dart';
import 'package:http/http.dart' as http;
import 'package:sufismart/util/system.dart';

import 'feedback_model.dart';

class RedeemPointUserModel {
  String? userid;
  String? merchantid;
  String? alamat;
  String? note;

  RedeemPointUserModel({
    this.userid,
    this.merchantid,
    this.alamat,
    this.note,
  });

  factory RedeemPointUserModel.fromJson(Map<String, dynamic> json) {
    return RedeemPointUserModel(
      userid: json["userid"] as String?,
      merchantid: json["merchantid"] as String?,
      alamat: json["alamat"] as String?,
      note: json["note"] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userid": userid,
      "merchantid": merchantid,
      "alamat": alamat,
      "note": note,
    };
  }

  static Future<FeedbackModel?> sendRedeemPoint({
    required RedeemPointUserModel redeemPointUserModel,
  }) {
    return http.post(Uri.parse(System.data.apiEndPoint.redeemPointSufismart()),
        body: json.encode(redeemPointUserModel.toJson()),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        }).then((value) {
      if (value.statusCode == 200) {
        ModeUtil.debugPrint(json.decode(value.body));
        ModeUtil.debugPrint("call feedback send redeem new api ${value.body}");
        return FeedbackModel.fromJson(json.decode(value.body));
      } else {
        ModeUtil.debugPrint("error not status code 200");
        throw value;
      }
    }).catchError((onError) {
      ModeUtil.debugPrint("error not status code 200 " + onError);
      throw onError;
    });
  }
}
