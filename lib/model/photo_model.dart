import 'dart:convert';
import 'package:http/http.dart' as http;

class PhotoModel {
  int? albumId;
  int? id;
  String? title;
  String? url;
  String? thumbnailUrl;

  PhotoModel({
    this.albumId,
    this.id,
    this.thumbnailUrl,
    this.title,
    this.url,
  });

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      albumId: json['albumId'] as int,
      id: json['id'] as int,
      thumbnailUrl: json['thumbnailUrl'] as String,
      title: json['title'] as String,
      url: json['url'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'albumId': albumId,
        'id': id,
        'thumbnailUrl': thumbnailUrl,
        'title': title,
        'url': url,
      };

  static Future<List<PhotoModel>> getAll() {
    return http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'))
        .then((value) {
      if (value.statusCode == 200) {
        return (json.decode(value.body) as List)
            .map((e) => PhotoModel.fromJson(e))
            .toList();
      } else {
        throw Exception('Failed to load album');
      }
    }).catchError((onError) {
      throw Exception('Failed to load album');
    });
  }
}
