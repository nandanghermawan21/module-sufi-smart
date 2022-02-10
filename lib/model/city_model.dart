class CityModel {
  String? id;
  String? provinceId;
  String? name;

  CityModel({
    this.id,
    this.provinceId,
    this.name,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json["id"] as String,
      provinceId: json["provinceId"] as String,
      name: json["name"] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'provinceId': provinceId,
      'name': name,
    };
  }

  static List<CityModel> getAll() {
    return [
      {"id": "8171", "provinceId": "81", "name": " Ambon"},
      {"id": "2171", "provinceId": "21", "name": " B A T A M"},
      {"id": "6471", "provinceId": "64", "name": " Balikpapan"},
      {"id": "1171", "provinceId": "11", "name": " Banda Aceh"},
      {"id": "1871", "provinceId": "18", "name": " Bandar Lampung"},
      {"id": "3273", "provinceId": "32", "name": " Bandung"},
      {"id": "3279", "provinceId": "32", "name": " Banjar"},
      {"id": "6372", "provinceId": "63", "name": " Banjar Baru"},
      {"id": "6371", "provinceId": "63", "name": " Banjarmasin"},
      {"id": "3579", "provinceId": "35", "name": " Batu"},
      {"id": "7472", "provinceId": "74", "name": " Baubau"},
      {"id": "3275", "provinceId": "32", "name": " Bekasi"},
      {"id": "1771", "provinceId": "17", "name": " Bengkulu"},
      {"id": "5272", "provinceId": "52", "name": " Bima"},
      {"id": "1276", "provinceId": "12", "name": " Binjai"},
      {"id": "7172", "provinceId": "71", "name": " Bitung"},
      {"id": "3572", "provinceId": "35", "name": " Blitar"},
    ].map((e) => CityModel.fromJson(e)).toList();
  }
}
