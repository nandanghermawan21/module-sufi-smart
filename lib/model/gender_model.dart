class GenderModel {
  int? id;
  String? name;

  GenderModel({
    this.id,
    this.name,
  });

  factory GenderModel.fromJson(Map<String, dynamic> json) {
    return GenderModel(
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

  static List<GenderModel> getAllGender() {
    return [
      GenderModel(id: 1, name: "Male"),
      GenderModel(id: 2, name: "Female"),
    ];
  }
}
