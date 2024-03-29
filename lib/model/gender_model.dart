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

  static Future<List<GenderModel>> getAll() {
    return http
        .get(
      Uri.parse(
        System.data.apiEndPoint.getAllGender(),
      ),
    )
        .then(
      (value) {
        if (value.statusCode == 200) {
          return (json.decode(value.body) as List)
              .map((e) => GenderModel.fromJson((e)))
              .toList();
        } else {
          throw value;
        }
      },
    ).catchError((onError) {
      throw onError;
    });
  }

  static Future<GenderModel> readGender(String gender) {
    return getAll().then(
      (value) {
        return value
            .where((e) => e.name?.toLowerCase() == gender.toLowerCase())
            .first;
      },
    ).catchError(
      (onError) {
        throw onError;
      },
    );
  }

  // return http
  //       .get(Uri.parse("http://api-suzuki.lemburkuring.id/api/city/getAll"))
  //       .then(
  //     (value) {
  //       if (value.statusCode == 200) {
  //         return (json.decode(value.body) as List)
  //             .map((e) => CityModel.fromJson(e))
  //             .toList();
  //       } else {
  //         throw value;
  //       }
  //     },
  //   ).catchError(
  //     (onError) {
  //       throw onError;
  //     },
  //   );
  // }
}
