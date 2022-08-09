import 'package:flutter/material.dart';
import 'package:sufismart/model/product_category_model.dart';

class ProductViewModel extends ChangeNotifier {
  Future<List<ProductCategoryModel>> allProductCategory =
      ProductCategoryModel.getProductCategory();

  Future<void> onRefreshHomePage() async {
    return Future.delayed(const Duration(seconds: 5));
  }

  void commit() {
    notifyListeners();
  }
}
