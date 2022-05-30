import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';

class GenderNewModel {
  final String? value;

  GenderNewModel({
    this.value,
  });

  factory GenderNewModel.fromJson(Map<String, dynamic> json) {
    return GenderNewModel(
      value: json["value"] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "value": value,
    };
  }

  static Future<List<GenderNewModel>> getListGender() {
    ModeUtil.debugPrint("call get gender api");
    return http
        .get(Uri.parse(System.data.apiEndPoint.getGender()))
        .then((value) {
      if (value.statusCode == 200) {
        ModeUtil.debugPrint("call get gender api 1 ${value.body}");
        return (json.decode(value.body) as List)
            .map((e) => GenderNewModel.fromJson(e))
            .toList();
      } else {
        throw value;
      }
    }).catchError((onError) {
      ModeUtil.debugPrint("masuk on error " + onError.toString());
      throw onError;
    });
  }

  static Future<GenderNewModel> readGender(String gender) {
    return getListGender().then(
      (value) {
        return value
            .where((e) =>
                e.value?.toLowerCase().contains(gender.toLowerCase()) == true)
            .first;
      },
    ).catchError(
      (onError) {
        throw onError;
      },
    );
  }
}
