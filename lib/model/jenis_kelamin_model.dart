import 'package:sufismart/util/system.dart';

class JenisKelaminModel {
  int? id;
  String? name;

  JenisKelaminModel({this.id, this.name});

  factory JenisKelaminModel.fromJson(Map<String, dynamic> json) {
    return JenisKelaminModel(
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

  static List<JenisKelaminModel> getAll() {
    return [
      JenisKelaminModel(
        id: 1,
        name: "LAKI-LAKI",
      ),
      JenisKelaminModel(
        id: 2,
        name: "PEREMPUAN",
      ),
    ];
  }
}
