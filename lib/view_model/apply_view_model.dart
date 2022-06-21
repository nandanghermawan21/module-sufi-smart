import 'package:flutter/material.dart';

import 'package:sufismart/model/apply_model.dart';
import 'package:sufismart/util/system.dart';

class ApplyViewModel extends ChangeNotifier {
  String? strUserid = System.data.global.customerNewModel?.userid;

  Future<List<ApplyModel>?> getApplyUser() {
    return ApplyModel.getListApplyUser(userid: strUserid);
  }

  void commit() {
    notifyListeners();
  }
}
