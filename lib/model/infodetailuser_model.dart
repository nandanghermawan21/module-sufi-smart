import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:sufismart/model/customernew_model.dart';
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';

class InfoDetailuserModel {
  String? userid; //"agie annan",
  String? nama; //"agie annan",
  String? telp; //"085715532031",
  String? tanggallahir; //"1998-06-06",
  String? gender; //"male",
  String? nik; //"123123",
  String? pekerjaan; //"Mahasiswa",
  String? nokon1; //"1006180000915",
  String? nokon2; //"",
  String? nokon3;

  InfoDetailuserModel({
    this.userid,
    this.nama,
    this.telp,
    this.tanggallahir,
    this.gender,
    this.nik,
    this.pekerjaan,
    this.nokon1,
    this.nokon2,
    this.nokon3,
  });

  factory InfoDetailuserModel.fromJson(Map<String, dynamic> json) {
    return InfoDetailuserModel(
      userid: json["userid"] as String?,
      nama: json["nama"] as String?,
      telp: json["telp"] as String?,
      tanggallahir: json["tanggallahir"] as String?,
      gender: json["gender"] as String?,
      nik: json["nik"] as String?,
      pekerjaan: json["pekerjaan"] as String?,
      nokon1: json["nokon1"] as String?,
      nokon2: json["nokon2"] as String?,
      nokon3: json["nokon3"] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userid': userid,
      'nama': nama,
      'telp': telp,
      'tanggallahir': tanggallahir,
      'gender': gender,
      'nik': nik,
      'pekerjaan': pekerjaan,
      'nokon1': nokon1,
      'nokon2': nokon2,
      'nokon3': nokon3,
    };
  }

  static Future<InfoDetailuserModel?> getDetailUser({
    required String? userid,
  }) {
    return http
        .get(Uri.parse(System.data.apiEndPoint.detailInfoUser(userid: userid)))
        .then((value) {
      if (value.statusCode == 200) {
        ModeUtil.debugPrint("call get detail user new api ${value.body}");
        return InfoDetailuserModel.fromJson(json.decode(value.body));
      }
    }).catchError((onError) {
      throw onError;
    });
  }

  static Future<CustomerNewModel?> updateDetailInfoUser({
    required InfoDetailuserModel? infoDetailuserModel,
  }) {
    return http.post(Uri.parse(System.data.apiEndPoint.updateProfilUser()),
        body: json.encode(infoDetailuserModel?.toJson()),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }).then((value) {
      if (value.statusCode == 200) {
        ModeUtil.debugPrint("call get data info user new api 3 ${value.body}");
        return CustomerNewModel.fromJson(json.decode(value.body));
      } else {
        throw value;
      }
    }).catchError((onError) {
      throw onError;
    });
  }
}
