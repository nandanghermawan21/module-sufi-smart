import 'package:flutter/material.dart';
import 'package:sufismart/model/gender_model.dart';

import '../model/kota_model.dart';

class SignUpViewModel extends ChangeNotifier {
  Future<void> onRefreshHomePage() async {
    return Future.delayed(const Duration(seconds: 5));
  }

  TextEditingController namaLengkapTextEditingController =
      TextEditingController();
  TextEditingController namaPenggunaTextEditingController =
      TextEditingController();
  TextEditingController telpTextEditingController = TextEditingController();
  TextEditingController kataSandiTextEditingController =
      TextEditingController();
  TextEditingController noKtpTextEditingController = TextEditingController();

  KotaModel? _kota;
  KotaModel? get kota => _kota;
  set kota(KotaModel? kota) {
    _kota = kota;
    commit();
  }

  GenderModel? _gender;
  GenderModel? get gender => _gender;
  set gender (GenderModel? gendertype) {
    _gender = gendertype;
    commit();
  }

  List<KotaModel> kotas = KotaModel.getAllKota();
  List<GenderModel> genders = GenderModel.getAllGender();

  bool _namaLengkap = false;
  bool get namaLengkap => _namaLengkap;
  set setNamaLengkap(bool namaLengkap) {
    _namaLengkap = namaLengkap;
    commit();
  }

  bool _namaPenguna = false;
  bool get namaPengguna => _namaPenguna;
  set setNamaPengguna(bool namaPengguna) {
    _namaPenguna = namaPengguna;
    commit();
  }

  bool _telp = false;
  bool get telp => _telp;
  set setTelp(bool telp) {
    _telp = telp;
    commit();
  }

  bool _noKtp = false;
  bool get noKtp => _noKtp;
  set setNoKtp(bool noKtp) {
    _noKtp = noKtp;
    commit();
  }

  bool _kataSandi = false;
  bool get kataSandi => _kataSandi;
  set setKataSandi(bool kataSandi) {
    _kataSandi = kataSandi;
    commit();
  }

  void regist() {
    namaLengkapTextEditingController.text.isEmpty
        ? setNamaLengkap = true
        : setNamaLengkap = false;
    namaPenggunaTextEditingController.text.isEmpty
        ? setNamaPengguna = true
        : setNamaPengguna = false;
    telpTextEditingController.text.isEmpty ? setTelp = true : setTelp = false;
    noKtpTextEditingController.text.isEmpty
        ? setNoKtp = true
        : setNoKtp = false;
    kataSandiTextEditingController.text.isEmpty
        ? setKataSandi = true
        : setKataSandi = false;
  }

  void commit() {
    notifyListeners();
  }
}
