import 'package:flutter/material.dart';
import 'package:sufismart/model/product_type_model.dart';

class ProductDetailViewModel extends ChangeNotifier {
  
  ProductTypeModel? productTypeModel;
  Future<void> onRefreshHomePage() async {
    return Future.delayed(const Duration(seconds: 5));
  }

  void commit() {
    notifyListeners();
  }
}
