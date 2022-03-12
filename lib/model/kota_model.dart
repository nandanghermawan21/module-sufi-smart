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
      "id": id,
      "name": name,
    };
  }

  static List<KotaModel> getAllKota() {
    return [
      KotaModel(
        id: 1,
        name: "JAKARTA",
      ),
      KotaModel(
        id: 2,
        name: "BANDUNG",
      ),
      KotaModel(
        id: 3,
        name: "SURABAYA",
      ),
      KotaModel(
        id: 4,
        name: "MAKASAR",
      ),
    ];
  }
}
