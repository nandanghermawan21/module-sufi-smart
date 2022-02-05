import 'package:flutter/material.dart';
import 'package:sufismart/model/loan_type_model.dart';
import'package:sufismart/model/area_model.dart';
import'package:sufismart/model/insurance_type_model.dart';

class CreditSimulationViewModel extends ChangeNotifier {
  LoanTypeModel? _loanType;
LoanTypeModel? getloanType =>_loanType;
setloanType(LoanTypeModel? type) {
_loanType = type;
commit();
  }

List<LoanTypeModel>loanTypes = LoanTypeModel.getForCreditSimulation();
AreaModel? _area;
AreaModel? getarea =>_area;
setarea(AreaModel? area) {
_area = area;
commit();
  }

List<AreaModel>areas = AreaModel.getAllArea();

finalList<InsuraceTypeModel>_insuranceType = [];

List<InsuraceTypeModel>getinsuranceType =>_insuranceType;
voidaddInsuranceType(InsuraceTypeModelinsuraceTypeModel) {
_insuranceType.add(insuraceTypeModel);
commit();
  }

voidremoveInsuranceType(InsuraceTypeModelinsuraceTypeModel) {
_insuranceType.remove(insuraceTypeModel);
commit();
  }

boolinsuranceTypeIsCheked(InsuraceTypeModelinsuraceTypeModel) {
return_insuranceType.contains(insuraceTypeModel);
  }

List<InsuraceTypeModel>insuranceTypes =
InsuraceTypeModel.getAllInsuranceType();

TextEditingControllerpriceController = TextEditingController();
double? _price = 0;
double? getprice =>_price;
setprice(double? price) {
_price = price;
calcPercentage();
commit();
  }

TextEditingControllerdpAmountController = TextEditingController();
double? _dpAmount = 0;
double? getdpAmount =>_dpAmount;
setdpAmount(double? amount) {
_dpAmount = amount;
calcPercentage();
commit();
  }

TextEditingControllerdownPaymentPercentageController =
TextEditingController();
double? _dpPercent = 0;
double? getdpPercent =>_dpPercent;
setdpPercent(double? dpPercent) {
_dpPercent = dpPercent;
_dpAmount = (_price ?? 8) * (_dpPercent ?? 0) / 100;
dpAmountController.text = (_dpPercent ?? 0) == 0
        ? ""
        : "Rp. " +
NumberFormat("#,###", System.data.strings!.locale)
                .format(_dpAmount);
commit();
  }

TextEditingValuepriceFormater(
TextEditingValueoldValue, TextEditingValuenewValue) {
String_val =
newValue.text.replaceAllMapped(RegExp("[^0-9]"), (match) =>"");
String_num = _val.isNotEmpty
        ? "Rp. " +
NumberFormat("#,###", System.data.strings!.locale)
                .format(double.parse(_val))
        : "";

if ((parseDoubleFromString(_num) ?? 0) < (_dpAmount ?? 0)) {
dpAmount = null;
dpAmountController.clear();
    }
returnTextEditingValue(
composing: newValue.composing,
selection: TextSelection.fromPosition(TextPosition(offset: _num.length)),
text: _num,
    );
  }

TextEditingValuedownPaymentAmountFormater(
TextEditingValueoldValue, TextEditingValuenewValue) {
String_val =
newValue.text.replaceAllMapped(RegExp("[^0-9]"), (match) =>"");
String_num = _val.isNotEmpty
        ? "Rp. " +
NumberFormat("#,###", System.data.strings!.locale)
                .format(double.parse(_val))
        : "";

if ((parseDoubleFromString(_num) ?? 0) > (_price ?? 0)) {
returnTextEditingValue(
composing: newValue.composing,
selection: TextSelection.fromPosition(
TextPosition(offset: oldValue.text.length)),
text: oldValue.text,
      );
    } else {
returnTextEditingValue(
composing: newValue.composing,
selection:
TextSelection.fromPosition(TextPosition(offset: _num.length)),
text: _num,
      );
    }
  }

TextEditingValuedownPaymentPercentageFormater(
TextEditingValueoldValue, TextEditingValuenewValue) {
String_val =
newValue.text.replaceAllMapped(RegExp("[^0-9]"), (match) =>"");
String_num = (_val.isNotEmpty&& (_price ?? 0) != 0)
        ? double.parse(_val) >100
            ? oldValue.text.replaceFirst(" %", "")
            : _val
        : "";
returnTextEditingValue(
composing: newValue.composing,
selection: TextSelection.fromPosition(TextPosition(offset: _num.length)),
text: (_num.isNotEmpty&& (_price ?? 0) != 0) ? _num + " %" : "",
    );
  }

voidcalcPercentage() {
_dpPercent = ((price ?? 0) == 0) || ((_dpAmount ?? 0) == 0)
        ? null
        : (_dpAmount! / _price!) * 100;
downPaymentPercentageController.text =
_dpPercent == null ? "" : _dpPercent!.toStringAsFixed(2) + " %";
  }

double? parseDoubleFromString(StringpriceString) {
returnpriceString.isNotEmpty
        ? double.parse(
priceString.replaceAllMapped(RegExp("[^0-9]"), (match) =>""))
        : null;
  }

voidcalculate() {}


  void commit() {
    notifyListeners();
  }
}
