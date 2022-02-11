import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sufismart/util/system.dart';

class CityModel {
  String? id;
  String? provinceId;
  String? name;

  CityModel({
    this.id,
    this.provinceId,
    this.name,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json["id"] as String,
      provinceId: json["provinceId"] as String,
      name: json["name"] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'provinceId': provinceId,
      'name': name,
    };
  }

  static Future<List<CityModel>> getAll() {
    return http.get(Uri.parse(System.data.apiEndPoint.getAllCity())).then(
      (value) {
        if (value.statusCode == 200) {
          return (json.decode(value.body) as List)
              .map((e) => CityModel.fromJson(e))
              .toList();
        } else {
          throw value;
        }
      },
    ).catchError(
      (onError) {
        throw onError;
      },
    );
  }
}
