import 'package:sufismart/util/system.dart';

class LoanTypeModel {
  int? id;
  String? name;

  LoanTypeModel({
    this.id,
    this.name,
  });

  factory LoanTypeModel.fromJson(Map<String, dynamic> json) {
    return LoanTypeModel(
      id: json["id"] as int,
      name: json["name"] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
    };
  }

  static List<LoanTypeModel> getForCreditSimulation() {
    return [
      LoanTypeModel(
        id: 1,
        name: System.data.strings!.motorCyclingFinancing,
      ),
      LoanTypeModel(
        id: 2,
        name: System.data.strings!.carFinancing,
      )
    ];
  }
}
