import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sufismart/util/system.dart';

class KtpModel {
  final String? agama;
  final String? alamat;
  final String? berlakuHingga;
  final String? golonganDarah;
  final String? jenisKelamin;
  final String? kecamatan;
  final String? kelurahanDesa;
  final String? kewarganegaraan;
  final String? kotaKabupaten;
  final String? nama;
  final String? nik;
  final String? pekerjaan;
  final String? provinsi;
  final String? rtRw;
  final String? statusPerkawinan;
  final String? tanggalLahir;
  final String? tempatLahir;

  KtpModel(
      {this.agama,
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
      this.tempatLahir});

  static KtpModel fromJson(Map<String, dynamic> json) {
    return KtpModel(
      agama: json["agama"] as String?,
      alamat: json["alamat"] as String?,
      berlakuHingga: json["berlakuHingga"] as String?,
      golonganDarah: json["golonganDarah"] as String?,
      jenisKelamin: json["jenisKelamin"] as String?,
      kecamatan: json["kecamatan"] as String?,
      kelurahanDesa: json["kelurahanDesa"] as String?,
      kewarganegaraan: json["kewarganegaraan"] as String?,
      kotaKabupaten: json["kotaKabupaten"] as String?,
      nama: json["nama"] as String?,
      nik: json["nik"] as String?,
      pekerjaan: json["pekerjaan"] as String?,
      provinsi: json["provinsi"] as String?,
      rtRw: json["rtRw"] as String?,
      statusPerkawinan: json["statusPerkawinan"] as String?,
      tanggalLahir: json["tanggalLahir"] as String?,
      tempatLahir: json["tempatLahir"] as String?,
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
