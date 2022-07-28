import 'package:flutter/material.dart';
import 'package:sufismart/component/circular_loader_component.dart';
import 'package:sufismart/model/merchant_model.dart';
import 'package:sufismart/model/redeempointuser_model.dart';
import 'package:sufismart/util/error_handling_util.dart';
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';

class MerchantViewModel extends ChangeNotifier {
  String? strUserid = System.data.global.customerNewModel?.userid;
  CircularLoaderController loadingController = CircularLoaderController();

  TextEditingController alamatTextController = TextEditingController();
  TextEditingController noteTextController = TextEditingController();
  final GlobalKey<FormState> formKeyContact = GlobalKey<FormState>();

  String? _alamat;
  String? get alamat => _alamat;
  set alamat(String? value) {
    _alamat = value;
    commit();
  }

  String? _note;
  String? get note => _note;
  set note(String? value) {
    _note = value;
    commit();
  }

  Future<List<MerchantModel>?> getListMerchantRedeem() {
    return MerchantModel.getListMerchant(
      userid: strUserid,
    );
  }

  void submitRedeemPoint(String? strmerchantid) {
    loadingController.startLoading();
    ModeUtil.debugPrint("alamat," + alamatTextController.text);
    ModeUtil.debugPrint("note," + noteTextController.text);
    ModeUtil.debugPrint("userid," + strUserid!);
    ModeUtil.debugPrint("merchantid," + strmerchantid!);

    RedeemPointUserModel.sendRedeemPoint(
            redeemPointUserModel: RedeemPointUserModel(
                userid: strUserid,
                merchantid: strmerchantid,
                alamat: alamatTextController.text,
                note: noteTextController.text))
        .then((value) {
      if (value != null) {
        if (value.stat == 0) {
          loadingController.stopLoading(
            isError: false,
            message: value.msg,
            duration: const Duration(seconds: 2),
            onCloseCallBack: () {
              Navigator.of(System.data.context).pop();
              commit();
            },
          );
        } else if (value.stat == 1) {
          loadingController.stopLoading(
            isError: true,
            message: value.msg,
            duration: const Duration(seconds: 2),
            onCloseCallBack: () {},
          );
        }
      }
    }).catchError((onError) {
      loadingController.stopLoading(
        isError: true,
        message: ErrorHandlingUtil.handleApiError(onError),
      );
    });
  }

  void commit() {
    notifyListeners();
  }
}
