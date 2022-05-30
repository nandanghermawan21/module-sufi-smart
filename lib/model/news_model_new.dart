import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';

class NewsModelNew {
  String? newsid;
  String? imagepath;
  String? title;
  String? desc;

  NewsModelNew({
    this.newsid,
    this.imagepath,
    this.title,
    this.desc,
  });

  factory NewsModelNew.fromJson(Map<String, dynamic> json) {
    return NewsModelNew(
      newsid: json["newsid"] as String?,
      imagepath: json["imagepath"] as String?,
      title: json["title"] as String?,
      desc: json["desc"] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'newsid': newsid,
        'imagepath': imagepath,
        'title': title,
        'desc': desc,
      };

  //berita di halaman home
  static Future<List<NewsModelNew>> getNewsHome() async {
    //ModeUtil.debugPrint("call get news api");
    return http
        .get(Uri.parse(System.data.apiEndPoint.getAllNewsHome()))
        .then((value) {
      //ModeUtil.debugPrint("call get news api 2");

      if (value.statusCode == 200) {
        var response = json.decode(value.body);

        // ModeUtil.debugPrint("call get news api 4 + ${response["data"]}");
        // ModeUtil.debugPrint("call get news api 3 ${value.body}");

        if (response["isSuccess"] == true) {
          return (response["data"] as List)
              .map((e) => NewsModelNew.fromJson(e))
              .toList();
        } else {
          ModeUtil.debugPrint("error parsing data");
          throw Exception('Failed to load News');
        }
      } else {
        ModeUtil.debugPrint("error not status Code 200->");
        throw value;
      }
    }).catchError((onError) {
      ModeUtil.debugPrint("masuk on error " + onError.toString());
      throw onError;
    });
  }

  //berita di list berita
  static Future<List<NewsModelNew>> getListNews() {
    ModeUtil.debugPrint("call get list news api");
    return http.get(Uri.parse(System.data.apiEndPoint.getListAllNews())).then((value) {
      if (value.statusCode == 200) {
        var response = json.decode(value.body);
        ModeUtil.debugPrint("call get list news api 4 + ${response["data"]}");
        ModeUtil.debugPrint("call get list news api 3 ${value.body}");

        if (response["isSuccess"] == true) {
          return (response["data"] as List)
              .map((e) => NewsModelNew.fromJson(e))
              .toList();
        } else {
          ModeUtil.debugPrint("error parsing data");
          throw Exception('Failed to load News');
        }
      } else {
        ModeUtil.debugPrint("error not status Code 200->");
        throw value;
      }
    }).catchError((onError) {
      ModeUtil.debugPrint("masuk on error " + onError.toString());
      throw onError;
    });
  }
}
