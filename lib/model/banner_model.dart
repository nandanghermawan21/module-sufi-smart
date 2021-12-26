import 'dart:convert';

import 'package:http/http.dart' as http;

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

  Future<List<BannerModel>> getAll() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((e) => BannerModel.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
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
