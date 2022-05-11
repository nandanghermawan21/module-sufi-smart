class InsuraceTypeModel {
  int? id;
  String? name;

  InsuraceTypeModel({
    this.id,
    this.name,
  });

  factory InsuraceTypeModel.fromJson(Map<String, dynamic> json) {
    return InsuraceTypeModel(
      id: json["id"] as int,
      name: json["name"] as String,
    );
  }

  Map<String, dynamic> tiJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  static List<InsuraceTypeModel> getAllInsuranceType() {
    return [
      InsuraceTypeModel(id: 1, name: "KOMPERHENSIVE"),
      InsuraceTypeModel(id: 1, name: "TLO"),
    ];
  }
}
