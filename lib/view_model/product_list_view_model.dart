import 'package:flutter/material.dart';
import 'package:sufismart/model/product_list_model.dart';

class ProductListViewModel extends ChangeNotifier {
  Future<List<ProductListModel>> getallProductList({
    String? categoryId,
  }) {
    return ProductListModel.getProductList(categoryId: categoryId);
  }

  Future<void> onRefreshHomePage() async {
    await Future.delayed(const Duration(seconds: 5));
    //getallProductList();
    commit();
  }

  void commit() {
    notifyListeners();
  }
}
