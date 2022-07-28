import 'package:flutter/material.dart';
import 'package:sufismart/model/historypoint_model.dart';
import 'package:sufismart/util/system.dart';

class HistoryPointViewModel extends ChangeNotifier {
  String? strUserid = System.data.global.customerNewModel?.userid;

  Future<List<HistoryModel>?> getHistoryPointUser() {
    return HistoryModel.getHistoryPoint(
      userid: strUserid,
    );
  }

  void commit() {
    notifyListeners();
  }
}
