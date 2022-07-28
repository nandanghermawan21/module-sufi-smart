import 'dart:convert';

import 'package:sufismart/util/mode_util.dart';
import 'package:http/http.dart' as http;
import 'package:sufismart/util/system.dart';

class ProductListModel {
  String? productcode;
  String? productname;
  String? productcategory;
  String? productimage;
  String? productprice;

  ProductListModel({
    this.productcode,
    this.productname,
    this.productcategory,
    this.productimage,
    this.productprice,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) {
    return ProductListModel(
      productcode: json["product_code"] as String?,
      productname: json["product_name"] as String?,
      productcategory: json["product_category"] as String?,
      productimage: json["product_image"] as String?,
      productprice: json["product_price"] as String?,
    );
  }
  Map<String, dynamic> toJson() => {
        'product_code': productcode,
        'product_name': productname,
        'product_category': productcategory,
        'product_image': productimage,
        'product_price': productprice
      };

  static Future<List<ProductListModel>> getProductList({
    required String? categoryId,
  }) {
    //ModeUtil.debugPrint("call get product list api");
    return http
        .get(
      Uri.parse(
          System.data.apiEndPoint.getListAllProduct(categoryId: categoryId)),
    )
        .then((value) {
      //ModeUtil.debugPrint("call get product list api 2");
      if (value.statusCode == 200) {
        var response = json.decode(value.body);
        ModeUtil.debugPrint(
            "call get Product list api 4 + ${response["data"]}");
        //ModeUtil.debugPrint("call get Product list api 3 ${value.body}");

        if (response["isSuccess"] == true) {
          return (response["data"] as List)
              .map((e) => ProductListModel.fromJson(e))
              .toList();
        } else {
          ModeUtil.debugPrint("error parsing data");
          throw Exception('Failed to load product list');
        }
      } else {
        ModeUtil.debugPrint("error not status Code 200->");
        throw value;
      }
    }).catchError((onError) {
      ModeUtil.debugPrint("masuk on error product list" + onError.toString());
      throw onError;
    });
  }
}
