import 'package:http/http.dart' as http;
import 'package:sufismart/util/api_end_point.dart';
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
        System.data.apiEndPoint!.getAllGender(),
      ),
    )
        .then(
      (value) {
        if (value.statusCode == 200) {
          return (value.body as List)
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
}
