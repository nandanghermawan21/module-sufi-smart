import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:sufismart/util/system.dart';

class PositionModel {
  int? id; //": 0,
  String? ref; //": "string",
  DateTime? createDate; //": "2022-04-05T16:01:52.680Z",
  double? lat; //": 0,
  double? lon; //": 0,
  double? direction;

  PositionModel({
    this.id,
    this.ref,
    this.createDate,
    this.lat,
    this.lon,
    this.direction,
  }); //": 0

  static PositionModel fromJson(Map<String, dynamic> json) {
    return PositionModel(
      id: json["id"] as int,
      ref: json["ref"] as String,
      createDate: json["createDate"] == null
          ? null
          : DateTime.parse(
              json['createDate'] as String,
            ),
      lat: (json["lat"] as num).toDouble(),
      lon: (json["lon"] as num).toDouble(),
      direction: (json["direction"] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "ref": ref,
      "createDate": createDate?.toIso8601String(),
      "lat": lat,
      "lon": lon,
      "direction": direction,
    };
  }

  static Future<PositionModel> save({
    required PositionModel positionModel,
  }) {
    return http.post(
      Uri.parse(
        System.data.apiEndPoint.savePosition(),
      ),
      body: json.encode(positionModel.toJson()),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
    ).then(
      (value) {
        if (value.statusCode == 200) {
          return PositionModel.fromJson(json.decode(value.body));
        } else {
          throw value;
        }
      },
    ).catchError((onError) {
      throw onError;
    });
  }

  static Future<List<PositionModel>> load({
    String? filter,
  }) {
    return http.get(
      Uri.parse(
        System.data.apiEndPoint.loadPosition(
          filter: filter,
        ),
      ),
      headers: {
        HttpHeaders.contentTypeHeader: Headers.jsonContentType,
      },
    ).then(
      (value) {
        if (value.statusCode == 200) {
          return (json.decode(value.body) as List)
              .map((e) => PositionModel.fromJson(e))
              .toList();
        } else {
          throw value;
        }
      },
    ).catchError((onError) {
      throw onError;
    });
  }
}
