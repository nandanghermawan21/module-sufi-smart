import 'package:flutter/material.dart';
import 'package:sufismart/model/product_type_model.dart';

class ProductTypeViewModel extends ChangeNotifier{

  Future<List<ProductTypeModel>> getAllProductType({
    String? productId,
  }){
    return ProductTypeModel.getListProductType(productId: productId);
  }
  
  Future<void> onRefreshHomePage() async {
    return Future.delayed(const Duration(seconds: 5));
  }

  void commit() {
    notifyListeners();
  }
}