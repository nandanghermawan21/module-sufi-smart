import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sufismart/component/circular_loader_component.dart';
import 'package:sufismart/model/branch_model.dart';
import 'package:sufismart/model/kota_branch_model.dart';
import 'package:sufismart/util/error_handling_util.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sufismart/util/mode_util.dart';

class BranchViewModel extends ChangeNotifier {
  CircularLoaderController loadingController = CircularLoaderController();
  ValueChanged<KotaBranchModel>? ontapSearchBranch;

  List<BranchModel> branchmodels = [];
  Future<List<KotaBranchModel>> kotaBranch =
      KotaBranchModel.getListKotaBranch();

  Future<Position?> getLocation() {
    return Permission.location.isGranted.then((granted) async {
      if (granted == true) {
        ModeUtil.debugPrint("send position user => Stream Position");
        return Geolocator.getCurrentPosition().then((value) {
          return value;
        });
      } else {
        return null;
      }
    }).catchError((onError) {
      throw onError;
    });
  }

  void getBranchId() {
    loadingController.startLoading();
    getLocation().then((value) {
      ModeUtil.debugPrint("masuk");
      ModeUtil.debugPrint("latitude ${value?.latitude}");
      ModeUtil.debugPrint("longitude ${value?.longitude}");
      BranchModel.getBranchByid(
              kotaBranch: kota?.kodekota,
              lat: value?.latitude,
              lng: value?.longitude)
          .then((value) {
        branchmodels = value;
        loadingController.forceStop();
        commit();
      }).catchError((onError) {
        loadingController.stopLoading(
          message: ErrorHandlingUtil.handleApiError(onError),
          isError: true,
        );
      });
    }).catchError((onError) {
      loadingController.stopLoading(
        message: ErrorHandlingUtil.handleApiError(onError),
        isError: true,
      );
    });
  }

  KotaBranchModel? _kota;
  KotaBranchModel? get kota => _kota;
  set kota(KotaBranchModel? value) {
    _kota = value;
    getBranchId();
  }

  void commit() {
    notifyListeners();
  }
}
