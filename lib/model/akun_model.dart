class AkunModel {
  int? id;
  String? nama;
  String? namapengguna;
  String? jeniskelamin;
  String? noktp;
  String? noponsel;
  String? kota;
  String? img;

  AkunModel(
      {this.id,
      this.nama,
      this.namapengguna,
      this.jeniskelamin,
      this.noktp,
      this.noponsel,
      this.kota,
      this.img});

  factory AkunModel.fromJson(Map<String, dynamic> json) {
    return AkunModel(
      id: json["id"] as int,
      nama: json["nama"] as String,
      namapengguna: json["namapengguna"] as String,
      jeniskelamin: json["jeniskelamin"] as String,
      noktp: json["noktp"] as String,
      noponsel: json["noponsel"] as String,
      kota: json["kota"] as String,
      img: json["img"] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'namapengguna': namapengguna,
      'jeniskelamin': jeniskelamin,
      'noktp': noktp,
      'noponsel': noponsel,
      'kota': kota,
      'img': img,
    };
  }

  static AkunModel data() {
    return AkunModel(
        id: 1,
        nama: "Muhamad Saptori",
        namapengguna: "Tori",
        jeniskelamin: "Laki-laki",
        noktp: "123456",
        noponsel: "087123121",
        kota: "Jakarta",
        img: "assets/bodyguard.png");
  }
}
