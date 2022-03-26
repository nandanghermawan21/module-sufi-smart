// TODO Implement this library.import 'dart:io';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sufismart/util/system.dart';

class KtpModel {
  String? agama; //": "PENGHAYAT KEPERCAYAAN",
  String? alamat; //": "BENDOREJO",
  String? berlakuHingga; //": "SEUMUR HIDUP",
  String? golonganDarah; //": "A",
  String? jenisKelamin; //": "LAKI-LAKI",
  String? kecamatan; //": "WONOGIRI",
  String? kelurahanDesa; //": "SENDANG",
  String? kewarganegaraan; //": "WNI",
  String? kotaKabupaten; //": "WONOGIRI",
  String? nama; //": "BAMBANG MULYONO",
  String? nik; //": "3312221203650001",
  String? pekerjaan; //": "WIRASWASTA",
  String? provinsi; //": "JAWA TENGAH",
  String? rtRw; //": "003/003",
  String? statusPerkawinan; //": "KAWIN",
  String? tanggalLahir; //": "12-03-1965",
  String? tempatLahir;

  KtpModel({
    this.agama,
    this.alamat,
    this.berlakuHingga,
    this.golonganDarah,
    this.jenisKelamin,
    this.kecamatan,
    this.kelurahanDesa,
    this.kewarganegaraan,
    this.kotaKabupaten,
    this.nama,
    this.nik,
    this.pekerjaan,
    this.provinsi,
    this.rtRw,
    this.statusPerkawinan,
    this.tanggalLahir,
    this.tempatLahir,
  }); //": "WONOGIRI"

  static KtpModel fromJson(Map<String, dynamic> json) {
    return KtpModel(
      agama: json["agama"] as String,
      alamat: json["alamat"] as String,
      berlakuHingga: json["berlakuHingga"] as String,
      golonganDarah: json["golonganDarah"] as String,
      jenisKelamin: json["jenisKelamin"] as String,
      kecamatan: json["kecamatan"] as String,
      kelurahanDesa: json["kelurahanDesa"] as String,
      kewarganegaraan: json["kewarganegaraan"] as String,
      kotaKabupaten: json["kotaKabupaten"] as String,
      nama: json["nama"] as String,
      nik: json["nik"] as String,
      pekerjaan: json["pekerjaan"] as String,
      provinsi: json["provinsi"] as String,
      rtRw: json["rtRw"] as String,
      statusPerkawinan: json["statusPerkawinan"] as String,
      tanggalLahir: json["tanggalLahir"] as String,
      tempatLahir: json["tempatLahir"] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "agama": agama,
      "alamat": alamat,
      "berlakuHingga": berlakuHingga,
      "golonganDarah": golonganDarah,
      "jenisKelamin": jenisKelamin,
      "kecamatan": kecamatan,
      "kelurahanDesa": kelurahanDesa,
      "kewarganegaraan": kewarganegaraan,
      "kotaKabupaten": kotaKabupaten,
      "nama": nama,
      "nik": nik,
      "pekerjaan": pekerjaan,
      "provinsi": provinsi,
      "rtRw": rtRw,
      "statusPerkawinan": statusPerkawinan,
      "tanggalLahir": tanggalLahir,
      "tempatLahir": tempatLahir,
    };
  }

  static Future<KtpModel> readFromImage({
    String? key,
    File? file,
  }) async {
    return Dio()
        .post(
      System.data.apiEndPoint.readKtp(),
      data: FormData.fromMap({
        "key": key,
        "image": await MultipartFile.fromFile(file!.path,
            filename: file.path.split("/").last),
      }),
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      ),
    )
        .then(
      (value) {
        if (value.statusCode == 200) {
          if (value.data["status"] == "Success") {
            return KtpModel.fromJson(value.data["read"]);
          } else {
            throw "image tidak valid";
          }
        } else {
          throw "image tidak valid";
        }
      },
    ).catchError(
      (onError) {
        throw "image tidak valid";
      },
    );
  }
}
