import 'package:flutter/material.dart';
import 'package:sufismart/model/jenis_kelamin_model.dart';
import 'package:sufismart/model/kota_model.dart';

class SignupViewModel extends ChangeNotifier {
  Future<void> onRefreshHomePage() async {
    return Future.delayed(const Duration(seconds: 5));
  }

  TextEditingController kTPTextEditingController = TextEditingController();
  TextEditingController namalengkapTextEditingController =
      TextEditingController();
  TextEditingController nohpTextEditingController = TextEditingController();
  TextEditingController namapenggunaTextEditingController =
      TextEditingController();
  TextEditingController katasandiTextEditingController =
      TextEditingController();

  String _ktp = "";
  String get getKtp => _ktp;
  set setKtp(String val) {
    _ktp = val;
    commit();
  }

  JenisKelaminModel? _jk;
  JenisKelaminModel? get jenisKelamin => _jk;
  set jenisKelamin(JenisKelaminModel? val) {
    _jk = val;
    commit();
  }

  List<JenisKelaminModel> listJenisKelamin = JenisKelaminModel.getAll();

  String _nama = "";
  String get getNama => _nama;
  set setNama(String val) {
    _nama = val;
    commit();
  }

  KotaModel? _kota;
  KotaModel? get getKota => _kota;
  set setKota(KotaModel? val) {
    _kota = val;
    commit();
  }

  List<KotaModel> listKota = KotaModel.getAllKota();

  String _nohp = "";
  String get getNohp => _nohp;
  set setNohp(String val) {
    _nohp = val;
    commit();
  }

  String _namapengguna = "";
  String get getNamaPengguna => _namapengguna;
  set setNamaPengguna(String val) {
    _namapengguna = val;
    commit();
  }

  String _katasandi = "";
  String get getKataSandi => _katasandi;
  set setKataSandi(String val) {
    _katasandi = val;
    commit();
  }

  void commit() {
    notifyListeners();
  }
}
