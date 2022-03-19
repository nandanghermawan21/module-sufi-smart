import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sufismart/util/system.dart';

class GenderModel {
  String? id;
  String? name;

  GenderModel({
    this.id,
    this.name,
  });

  factory GenderModel.fromJson(Map<String, dynamic> json) {
    return GenderModel(
      id: json["id"] as String,
      name: json["name"] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  // static List<GenderModel> getAll() {
  //   return [
  //     {"id": "L", "name": "Laki-Laki"},
  //     {"id": "P", "name": "Perempuan"}
  //   ].map((e) => GenderModel.fromJson(e)).toList();
  // }

  static Future<List<GenderModel>> getAll() {
    return http
        .get(Uri.parse(System.data.apiEndPoint!.getAllGender()))
        .then((value) {
      if (value.statusCode == 200) {
        // (value.body.toString() as List)
        //     .map((e) => GenderModel.fromJson(json.decode(e)))
        //     .toList()
        return (json.decode(value.body) as List)
            .map((e) => GenderModel.fromJson(json.decode(e)))
            .toList();
      } else {
        throw value;
      }
    }).catchError((onError) {
      throw onError;
    });
  }
}
