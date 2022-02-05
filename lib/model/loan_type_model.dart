import'package:sufismart/util/system.dart';

classLoanTypeModel {
int? id;
String? name;

LoanTypeModel({
this.id,
this.name,
  });

factoryLoanTypeModel.fromJson(Map<String, dynamic>json) {
returnLoanTypeModel(
id: json["id"] asint,
name: json["name"] asString,
    );
  }

Map<String, dynamic>toJson() {
return {
"id": id,
"name": name,
    };
  }

staticList<LoanTypeModel>getForCreditSimulation() {
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
