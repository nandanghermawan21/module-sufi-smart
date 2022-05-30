import 'dart:convert';

import 'package:sufismart/util/mode_util.dart';
import 'package:http/http.dart' as http;
import 'package:sufismart/util/system.dart';

class ProductTypeModel {
  String? productCode;
  String? productDetailCode;
  String? productDetailName;
  String? productDetailPrice;
  String? productDetailImage;
  String? productName;
  String? prodType;
  String? productCategory;
  String? productCategoryCode;

  ProductTypeModel({
    this.productCode,
    this.productDetailCode,
    this.productDetailName,
    this.productDetailPrice,
    this.productDetailImage,
    this.productName,
    this.prodType,
    this.productCategory,
    this.productCategoryCode,
  });

  factory ProductTypeModel.fromJson(Map<String, dynamic> json) {
    return ProductTypeModel(
      productCode: json["product_code"] as String?,
      productDetailCode: json["product_d_code"] as String?,
      productDetailName: json["product_d_name"] as String?,
      productDetailPrice: json["product_d_price"] as String?,
      productDetailImage: json["product_image"] as String?,
      productName: json["product_name"] as String?,
      prodType: json["product_type"] as String?,
      productCategory: json["product_category"] as String?,
      productCategoryCode: json["product_category_code"] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        "product_code": productCode,
        "product_d_code": productDetailCode,
        "product_d_name": productDetailName,
        "product_d_price": productDetailPrice,
        "product_image": productDetailImage,
        "product_name": productName,
        "product_type": prodType,
        "product_category": productCategory,
        "product_category_code": productCategoryCode,
      };

  static Future<List<ProductTypeModel>> getListProductType({
    required String? productId,
  }) {
    return http
        .get(Uri.parse(System.data.apiEndPoint
            .getListAllProductType(productId: productId)))
        .then((value) {
      if (value.statusCode == 200) {
        var response = json.decode(value.body);
        ModeUtil.debugPrint(
            "call get Product type api 4 + ${response["data"]}");
        ModeUtil.debugPrint("call get Product type api 3 ${value.body}");
        if (response["isSuccess"] == true) {
          return (response["data"] as List)
              .map((e) => ProductTypeModel.fromJson(e))
              .toList();
        } else {
          ModeUtil.debugPrint("error parsing data");
          throw Exception('Failed to load product type');
        }
      } else {
        ModeUtil.debugPrint("error not status Code 200->");
        throw value;
      }
    }).catchError((onError) {
      ModeUtil.debugPrint("masuk on error product type" + onError.toString());
      throw onError;
    });
  }
}
