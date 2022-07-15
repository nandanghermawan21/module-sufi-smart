import 'package:flutter/material.dart';
import 'package:sufismart/model/popup_model.dart';

class NotifViewModel extends ChangeNotifier {
  Future<PopupModel?> getDataNotifByid({
    required String? id,
  }) {
    return PopupModel.getDataNotifByid(id: id);
  }

  void commit() {
    notifyListeners();
  }
}
