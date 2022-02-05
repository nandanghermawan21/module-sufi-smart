classInsuraceTypeModel {
int? id;
String? name;

InsuraceTypeModel({
this.id,
this.name,
  });

factoryInsuraceTypeModel.fromJson(Map<String, dynamic>json) {
returnInsuraceTypeModel(
id: json["id"] asint,
name: json["name"] asString,
    );
  }

Map<String, dynamic>tiJson() {
return {
'id': id,
'name': name,
    };
  }

staticList<InsuraceTypeModel>getAllInsuranceType() {
return [
InsuraceTypeModel(id: 1, name: "KOMPERHENSIVE"),
InsuraceTypeModel(id: 1, name: "TLO"),
    ];
  }
}
