import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sufismart/model/city_model.dart';
import 'package:sufismart/model/gender_model.dart';
import 'package:sufismart/component/image_picker_component.dart';
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';

class SignupViewModel extends ChangeNotifier {
  TextEditingController nikController = TextEditingController();
  ImagePickerController controller = ImagePickerController();
  String? fileName;

  String? _nik;
  String? get nik => _nik;
  set nik(String? value) {
    _nik = value;
    commit();
  }

  GenderModel? _gender;
  GenderModel? get gender => _gender;
  set gender(GenderModel? type) {
    _gender = type;
    commit();
  }

  List<GenderModel> genders = GenderModel.getAll();

  CityModel? _city;
  CityModel? get city => _city;
  set city(CityModel? type) {
    _city = type;
    commit();
  }

  List<CityModel> citys = CityModel.getAll();

  TextEditingController fullnameController = TextEditingController();
  String? _fullname;
  String? get fullname => _fullname;
  set fullname(String? value) {
    _nik = value;
    commit();
  }

  TextEditingController phonenumberController = TextEditingController();
  String? _phonenumber;
  String? get phonenumber => _phonenumber;
  set phonenumber(String? value) {
    _nik = value;
    commit();
  }

  TextEditingController usernameController = TextEditingController();
  String? _username;
  String? get username => _username;
  set username(String? value) {
    _nik = value;
    commit();
  }

  TextEditingController passwordController = TextEditingController();
  String? _password;
  String? get password => _password;
  set password(String? value) {
    _nik = value;
    commit();
  }

  void register({VoidCallback? onRegisterSuccess}) {
    fileName = "fasdfasdfasdfafsdfasdf";
    String url =
        "http://api-suzuki.lemburkuring.id/api/Fileservice/upload?path=testupload&name=$fileName";
    controller.uploadFile(
      url: url,
      header: {
        HttpHeaders.authorizationHeader: "bearer ${System.data.global.token}"
      },
    ).then((value) {
      controller.value.uploadedUrl = json.decode(value)["url"] as String;
      controller.commit();
    }).catchError(
      (onError) {
        ModeUtil.debugPrint("error dari upload adalah $onError");
      },
    );
  }

  void commit() {
    notifyListeners();
  }
}
