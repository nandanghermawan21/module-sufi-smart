import 'package:flutter/material.dart';
import 'package:sufismart/model/loan_type_model.dart';
import 'package:sufismart/model/area_model.dart';
import 'package:sufismart/model/insurance_type_model.dart';

class CreditSimulationViewModel extends ChangeNotifier {
  LoanTypeModel? _loanType;
  LoanTypeModel? get loanType => _loanType;
  set loanType(LoanTypeModel? type) {
    _loanType = type;
    commit();
  }

  List<LoanTypeModel> loanTypes = LoanTypeModel.getForCreditSimulation();

  AreaModel? _area;
  AreaModel? get area => _area;
  set area(AreaModel? area) {
    _area = area;
    commit();
  }

  List<AreaModel> areas = AreaModel.getAllArea();

  final List<InsuraceTypeModel> _insuranceType = [];
  List<InsuraceTypeModel> get insuranceType => _insuranceType;
  void addInsuranceType(InsuraceTypeModel insuraceTypeModel) {
    _insuranceType.add(insuraceTypeModel);
    commit();
  }

  void removeInsuranceType(InsuraceTypeModel insuraceTypeModel) {
    _insuranceType.remove(insuraceTypeModel);
    commit();
  }

  bool insuranceTypeIsCheked(InsuraceTypeModel insuraceTypeModel) {
    return _insuranceType.contains(insuraceTypeModel);
  }

  List<InsuraceTypeModel> insuranceTypes =
      InsuraceTypeModel.getAllInsuranceType();

  void commit() {
    notifyListeners();
  }
}
