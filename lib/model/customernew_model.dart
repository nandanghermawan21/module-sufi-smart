import 'dart:convert';
import 'dart:io';
import 'package:sufismart/model/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';

class CustomerNewModel {
  String? userid;
  String? status;
  String? name;
  String? email;
  String? msg;
  String? birthdate;
  String? job;
  String? nik;
  String? nohp;
  String? gender;
  String? deviceid;
  String? imageuser;
  DateTime? expired;
  String? tipe;
  String? reveralid;
  String? idkomunitas;

  CustomerNewModel(
      {this.userid,
      this.status,
      this.name,
      this.email,
      this.msg,
      this.birthdate,
      this.job,
      this.nik,
      this.nohp,
      this.gender,
      this.deviceid,
      this.imageuser,
      this.expired,
      this.tipe,
      this.reveralid,
      this.idkomunitas});

  factory CustomerNewModel.fromJson(Map<String, dynamic> json) {
    return CustomerNewModel(
      userid: json["userid"] as String?,
      status: json["status"] as String?,
      name: json["name"] as String?,
      email: json["email"] as String?,
      msg: json["msg"] as String?,
      birthdate: json["birthdate"] as String?,
      job: json["job"] as String?,
      nik: json["nik"] as String?,
      nohp: json["nohp"] as String?,
      gender: json["gender"] as String?,
      deviceid: json["deviceid"] as String?,
      imageuser: json["imageuser"] as String?,
      expired: json["expired"] == null
          ? null
          : DateTime.parse(json['expired'] as String),
      tipe : json["tipe"] as String?,
      reveralid : json["reveralid"] as String?,
      idkomunitas : json["idkomunitas"] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userid': userid,
      'status': status,
      'name': name,
      'email': email,
      'msg': msg,
      'birthdate': birthdate,
      'job': job,
      'nik': nik,
      'nohp': nohp,
      'gender': gender,
      'deviceid': deviceid,
      'imageuser': imageuser,
      'expired' : expired,
      'tipe' : tipe,
      'reveralid' : reveralid,
      'idkomunitas' : idkomunitas,
    };
  }

  static Future<CustomerNewModel?> login({
    required UserModel? user,
  }) {
    ModeUtil.debugPrint("call get login new api");

    return http.post(Uri.parse(System.data.apiEndPoint.loginCustomerNew()),
        body: json.encode(user?.toJson()),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }).then((value) {
      ModeUtil.debugPrint(json.encode(user?.toJson()));
      ModeUtil.debugPrint("call get login new api 2 ${value.body}");

      if (value.statusCode == 200) {
        ModeUtil.debugPrint(json.decode(value.body));
        //ModeUtil.debugPrint("call get login api 4 + ${response["data"]}");
        ModeUtil.debugPrint("call get login new api 3 ${value.body}");
        return CustomerNewModel.fromJson(json.decode(value.body));
      } else {
        ModeUtil.debugPrint("error not status Code 200->");
        throw value;
      }
    }).catchError((onError) {
      ModeUtil.debugPrint("masuk on error login" + onError.toString());
      throw onError;
    });
  }
}
