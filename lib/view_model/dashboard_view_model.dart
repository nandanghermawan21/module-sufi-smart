import 'package:flutter/material.dart';
import 'package:sufismart/model/point_model.dart';

class DashboardViewModel extends ChangeNotifier {

  Future<PointModel?> getDataPointById({
    required String? id,
  }) {
    return PointModel.getPointUser(id: id);
  }

  void commit() {
    notifyListeners();
  }
}
