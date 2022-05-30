import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';

class BranchModel {
  String? officename; // "BALIKPAPAN",
  String?
      addr; // "MT Haryono Dalam Kel. Damai Kec Balikpapan Selatan Prov Kalimantan Timur ,76125",
  String? tagname; // "SUZUKI FINANCE INDONESIA CABANG BALIKPAPAN",
  String? lat; // "-1.216471",
  String? lng;
  String? jarak;

  BranchModel({
    this.officename,
    this.addr,
    this.tagname,
    this.lat,
    this.lng,
    this.jarak,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return BranchModel(
      officename: json["office_name"] as String?,
      addr: json["addr"] as String?,
      tagname: json["tag_name"] as String?,
      lat: json["lat"] as String?,
      lng: json["lng"] as String?,
      jarak: json["jarak"] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'office_name': officename,
        'addr': addr,
        'tag_name': tagname,
        'lat': lat,
        'lng': lng,
        'jarak': jarak,
      };

  static Future<List<BranchModel>> getBranchByid({
    required String? kotaBranch,
    required double? lat,
    required double? lng,
  }) {
    ModeUtil.debugPrint("call get branch by id api");
    return http
        .get(Uri.parse(System.data.apiEndPoint.getListDetailBranchById(
            kodeBranch: kotaBranch, lat: lat, lng: lng)))
        .then((value) {
      ModeUtil.debugPrint("call get branch by id api 2");
      if (value.statusCode == 200) {
        var response = json.decode(value.body);
        ModeUtil.debugPrint(
            "call get branch by id api 4 + ${response["data"]}");
        ModeUtil.debugPrint("call get branch by id api 3 ${value.body}");
        if (response["isSuccess"] == true) {
          return (response["data"] as List)
              .map((e) => BranchModel.fromJson(e))
              .toList();
        } else {
          ModeUtil.debugPrint("error parsing data");
          throw Exception('Failed to load product branch by id');
        }
      } else {
        ModeUtil.debugPrint("error not status Code 200->");
        throw value;
      }
    }).catchError((onError) {
      ModeUtil.debugPrint("masuk on error branch by id" + onError.toString());
      throw onError();
    });
  }
}
