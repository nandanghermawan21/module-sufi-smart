import 'package:flutter/material.dart';
import 'package:sufismart/model/loan_type_model.dart';

class CreditSimulationViewModel extends ChangeNotifier {
  LoanTypeModel? _loanType;
  LoanTypeModel? get loanType => _loanType;
  set loanType(LoanTypeModel? type) {
    _loanType = type;
    commit();
  }

  List<LoanTypeModel> loanTypes = LoanTypeModel.getForCreditSimulation();

  void commit() {
    notifyListeners();
  }
}
