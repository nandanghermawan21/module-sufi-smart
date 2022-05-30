import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';

class BannerModel {
  String? imagepath;
  BannerModel({
    this.imagepath,
  });

  BannerModel.fromJson(Map<String, dynamic> json)
      : imagepath = json['imagepath'];

  Map<String, dynamic> toJson() => {
        'imagepath': imagepath,
      };

  static Future<List<BannerModel>> getAll() async {
    ModeUtil.debugPrint("call get Banner api");
    return http.get(Uri.parse(System.data.apiEndPoint.getAllBanner())).then(
      (value) {
        //ModeUtil.debugPrint("call get Banner api 2");
        if (value.statusCode == 200) {
          var response = json.decode(value.body);
          ModeUtil.debugPrint("call get Banner api 4 + ${response["data"]}");
          ModeUtil.debugPrint("call get Banner api 3 ${value.body}");
          ModeUtil.debugPrint("Success -> " + response.toString());
          if (response["isSuccess"] == true) {
            return (response["data"] as List)
                .map((e) => BannerModel.fromJson(e))
                .toList();
          } else {
             ModeUtil.debugPrint("error parsing data");
            throw Exception('Failed to load album');
          }
        } else {
          ModeUtil.debugPrint("error not status Code 200->");
          throw value;
        }
      },
    ).catchError((onError) {
      ModeUtil.debugPrint("masuk on error " + onError.toString());
      throw onError;
    });
  }

  static List<BannerModel> dummy() {
    return [
      BannerModel(
        imagepath: "assets/1.jpg",
      ),
      BannerModel(
        imagepath: "assets/2.jpg",
      ),
      BannerModel(
        imagepath: "assets/3.jpg",
      ),
    ];
  }
}
