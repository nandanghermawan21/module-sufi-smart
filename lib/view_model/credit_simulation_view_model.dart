import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sufismart/model/area_model.dart';
import 'package:sufismart/model/insurance_type_model.dart';
import 'package:sufismart/model/loan_type_model.dart';
import 'package:sufismart/util/system.dart';

class CreditSimulationViewModel extends ChangeNotifier {
  LoanTypeModel? _loanType;
  LoanTypeModel? get loanType => _loanType;
  set loanType(LoanTypeModel? type) {
    _loanType = type;
    commit();
  }

  AreaModel? _area;
  AreaModel? get area => _area;
  set area(AreaModel? area) {
    _area = area;
    commit();
  }

  double? _price = 0;
  double? get price => _price;
  set price(double? price) {
    _price = price;
    calcPercentage();
    commit();
  }

  double? _dpAmount = 0;
  double? get dpAmount => _dpAmount;
  set dpAmount(double? amount) {
    _dpAmount = amount;
    calcPercentage();
    commit();
  }

  double? _dpPercent = 0;
  double? get dpPercent => _dpPercent;
  set dpPercent(double? dpPercent) {
    _dpPercent = dpPercent;
    _dpAmount = (_price ?? 8) * (_dpPercent ?? 0) / 100;
    downPaymentAmountController.text = "Rp. " +
        NumberFormat("#,###", System.data.strings!.locale).format(_dpAmount);
    commit();
  }

  void calcPercentage() {
    _dpPercent = ((price ?? 0) == 0) || ((_dpAmount ?? 0) == 0)
        ? null
        : (_dpAmount! / _price!) * 100;
    downPaymentPercentageController.text =
        _dpPercent == null ? "" : _dpPercent!.toStringAsFixed(2) + " %";
  }

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

  double? parseDoubleFromString(String priceString) {
    return priceString.isNotEmpty
        ? double.parse(
            priceString.replaceAllMapped(RegExp("[^0-9]"), (match) => ""))
        : null;
  }

  void calculate() {}

  List<LoanTypeModel> loanTypes = LoanTypeModel.getForCreditSimulation();
  List<AreaModel> areas = AreaModel.getAllArea();
  List<InsuraceTypeModel> insuranceTypes =
      InsuraceTypeModel.getAllInsuranceType();

  TextEditingController priceController = TextEditingController();
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
      downPaymentAmountController.clear();
    }
    return TextEditingValue(
      composing: newValue.composing,
      selection: TextSelection.fromPosition(TextPosition(offset: _num.length)),
      text: _num,
    );
  }

  TextEditingController downPaymentAmountController = TextEditingController();
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

  TextEditingController downPaymentPercentageController =
      TextEditingController();
  TextEditingValue downPaymentPercentageFormater(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String _val =
        newValue.text.replaceAllMapped(RegExp("[^0-9]"), (match) => "");
    String _num = _val.isNotEmpty
        ? double.parse(_val) > 100
            ? oldValue.text.replaceFirst(" %", "")
            : _val
        : "";
    return TextEditingValue(
      composing: newValue.composing,
      selection: TextSelection.fromPosition(TextPosition(offset: _num.length)),
      text: _num.isNotEmpty ? _num + " %" : "",
    );
  }

  void commit() {
    notifyListeners();
  }
}
