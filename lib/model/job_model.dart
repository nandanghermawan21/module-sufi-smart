import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';

class JobModel {
  String? value;

  JobModel({
    this.value,
  });
  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      value: json["value"] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "value": value,
    };
  }

  static Future<List<JobModel>> getListJob() {
    ModeUtil.debugPrint("call get Job Api");
    return http.get(Uri.parse(System.data.apiEndPoint.getJob())).then((value) {
      if (value.statusCode == 200) {
        ModeUtil.debugPrint("call get Job Api 1 ${value.body}");
        return (json.decode(value.body) as List)
            .map((e) => JobModel.fromJson(e))
            .toList();
      } else {
        throw value;
      }
    }).catchError((onError) {
      ModeUtil.debugPrint("on error get Job Api " + onError);
      throw onError;
    });
  }

  static Future<JobModel> readJob(String job) {
    return getListJob().then(
      (value) {
        return value
            .where((e) =>
                e.value?.toLowerCase().contains(job.toLowerCase()) == true)
            .first;
      },
    ).catchError(
      (onError) {
        throw onError;
      },
    );
  }
}
