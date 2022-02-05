import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sufismart/model/loan_type_model.dart';
import 'package:sufismart/model/area_type_model.dart';
import 'package:sufismart/model/insurance_type_model.dart';

import '../util/system.dart';

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

  TextEditingController priceController = TextEditingController();
  double? _price = 0;
  double? get price => _price;
  set price(double? price) {
    _price = price;
    calcPercentage();
    commit();
  }

  TextEditingController dpAmountController = TextEditingController();
  double? _dpAmount = 0;
  double? get dpAmount => _dpAmount;
  set dpAmount(double? amount) {
    _dpAmount = amount;
    calcPercentage();
    commit();
  }

  TextEditingController downPaymentPercentageController =
      TextEditingController();
  double? _dpPercent = 0;
  double? get dpPercent => _dpPercent;
  set dpPercent(double? dpPercent) {
    _dpPercent = dpPercent;
    _dpAmount = (_price ?? 8) * (_dpPercent ?? 0) / 100;
    dpAmountController.text = (_dpPercent ?? 0) == 0
        ? ""
        : "Rp. " +
            NumberFormat("#,###", System.data.strings!.locale)
                .format(_dpAmount);
    commit();
  }

  TextEditingValue priceFormater(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String _val =
        newValue.text.replaceAllMapped(RegExp("[^0-9]"), (match) => "");
    String _num = _val.isNotEmpty
        ? "Rp. " +
            NumberFormat("#,###", System.data.strings!.locale)
                .format(double.parse(_val))
        : "";

    if ((parseDoubleFromString(_num) ?? 0) < (_dpAmount ?? 0)) {
      dpAmount = null;
      dpAmountController.clear();
    }
    return TextEditingValue(
      composing: newValue.composing,
      selection: TextSelection.fromPosition(TextPosition(offset: _num.length)),
      text: _num,
    );
  }

  TextEditingValue downPaymentAmountFormater(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String _val =
        newValue.text.replaceAllMapped(RegExp("[^0-9]"), (match) => "");
    String _num = _val.isNotEmpty
        ? "Rp. " +
            NumberFormat("#,###", System.data.strings!.locale)
                .format(double.parse(_val))
        : "";

    if ((parseDoubleFromString(_num) ?? 0) > (_price ?? 0)) {
      return TextEditingValue(
        composing: newValue.composing,
        selection: TextSelection.fromPosition(
            TextPosition(offset: oldValue.text.length)),
        text: oldValue.text,
      );
    } else {
      return TextEditingValue(
        composing: newValue.composing,
        selection:
            TextSelection.fromPosition(TextPosition(offset: _num.length)),
        text: _num,
      );
    }
  }

  TextEditingValue downPaymentPercentageFormater(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String _val =
        newValue.text.replaceAllMapped(RegExp("[^0-9]"), (match) => "");
    String _num = (_val.isNotEmpty && (_price ?? 0) != 0)
        ? double.parse(_val) > 100
            ? oldValue.text.replaceFirst(" %", "")
            : _val
        : "";
    return TextEditingValue(
      composing: newValue.composing,
      selection: TextSelection.fromPosition(TextPosition(offset: _num.length)),
      text: (_num.isNotEmpty && (_price ?? 0) != 0) ? _num + " %" : "",
    );
  }

  void calcPercentage() {
    _dpPercent = ((price ?? 0) == 0) || ((_dpAmount ?? 0) == 0)
        ? null
        : (_dpAmount! / _price!) * 100;
    downPaymentPercentageController.text =
        _dpPercent == null ? "" : _dpPercent!.toStringAsFixed(2) + " %";
  }

  double? parseDoubleFromString(String priceString) {
    return priceString.isNotEmpty
        ? double.parse(
            priceString.replaceAllMapped(RegExp("[^0-9]"), (match) => ""))
        : null;
  }

  void calculate() {}

  void commit() {
    notifyListeners();
  }
}
