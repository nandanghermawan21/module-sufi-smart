class KotaModel {
  int? id;
  String? name;

  KotaModel({this.id, this.name});

  factory KotaModel.fromJson(Map<String, dynamic> json) {
    return KotaModel(
      id: json["id"] as int,
      name: json["name"] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  static List<KotaModel> getAllKota() {
    return [
      KotaModel(
        id: 1,
        name: "Jakarta",
      ),
      KotaModel(
        id: 2,
        name: "Bekasi",
      ),
      KotaModel(
        id: 3,
        name: "Depok",
      ),
      KotaModel(
        id: 4,
        name: "Bandung",
      ),
      KotaModel(
        id: 5,
        name: "Tangerang",
      ),
      KotaModel(
        id: 6,
        name: "Bogor",
      ),
    ];
  }
}
