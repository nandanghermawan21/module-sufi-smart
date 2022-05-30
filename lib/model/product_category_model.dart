import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';

class ProductCategoryModel {
  String? categorycode;
  String? categoryname;
  String? categoryimage;

  ProductCategoryModel(
      {this.categorycode, this.categoryname, this.categoryimage});

  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) {
    return ProductCategoryModel(
      categorycode: json["category_code"] as String?,
      categoryname: json["category_name"] as String?,
      categoryimage: json["category_image"] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'category_code': categorycode,
        'category_name': categoryname,
        'category_image': categoryimage,
      };

  static Future<List<ProductCategoryModel>> getProductCategory() async {
    ModeUtil.debugPrint("call get product category api");
    return http
        .get(Uri.parse(System.data.apiEndPoint.getListAllProductCategory()))
        .then((value) {
      ModeUtil.debugPrint("call get product category api 2");
      if (value.statusCode == 200) {
        var response = json.decode(value.body);

        ModeUtil.debugPrint(
            "call get Product Category api 4 + ${response["data"]}");
        ModeUtil.debugPrint("call get Product Category api 3 ${value.body}");

        if (response["isSuccess"] == true) {
          return (response["data"] as List)
              .map((e) => ProductCategoryModel.fromJson(e))
              .toList();
        } else {
          ModeUtil.debugPrint("error parsing data");
          throw Exception('Failed to load product model');
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
