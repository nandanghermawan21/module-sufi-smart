class AreaModel {
  int? id;
  String? name;

  AreaModel({
    this.id,
    this.name,
  });

  factory AreaModel.fromJson(Map<String, dynamic> json) {
    return AreaModel(
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

  static List<AreaModel> getAllArea() {
    return [
      AreaModel(
        id: 1,
        name: "JABODETABEKSER",
      ),
      AreaModel(
        id: 2,
        name: "JAWA BARAT",
      ),
      AreaModel(
        id: 3,
        name: "JAWA TENGAH",
      ),
      AreaModel(
        id: 4,
        name: "JAWA TIMUR",
      ),
      AreaModel(
        id: 5,
        name: "JAWA KALIMANTAN",
      ),
      AreaModel(
        id: 6,
        name: "SULAWESI",
      ),
      AreaModel(
        id: 7,
        name: "SUMATERA",
      ),
    ];
  }
}
