class GenderModel {
  String? id;
  String? name;

  GenderModel({
    this.id,
    this.name,
  });

  factory GenderModel.fromJson(Map<String, dynamic> json) {
    return GenderModel(
      id: json["id"] as String,
      name: json["name"] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  static List<GenderModel> getAll() {
    return [
      {"id": "L", "name": "Laki-Laki"},
      {"id": "P", "name": "Perempuan"}
    ].map((e) => GenderModel.fromJson(e)).toList();
  }
}
