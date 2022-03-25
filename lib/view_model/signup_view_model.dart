import 'package:flutter/material.dart';
import 'package:sufismart/component/image_picker_component.dart';
import 'package:sufismart/model/city_model.dart';
import 'package:sufismart/model/customer_model.dart';
import 'package:sufismart/model/customer_register_model.dart';
import 'package:sufismart/model/gender_model.dart';
import 'package:sufismart/util/error_handling_util.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/component/cilcular_loader_component.dart';

class SignupViewModel extends ChangeNotifier {
  CircularLoaderController loadingController = CircularLoaderController();

  TextEditingController nikController = TextEditingController();
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

  CityModel? _city;
  CityModel? get city => _city;
  set city(CityModel? type) {
    _city = type;
    commit();
  }

  Future<List<CityModel>> cities = CityModel.getAll();

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

  ImagePickerController imagePickerController = ImagePickerController();

  void register({VoidCallback? onRegisterSuccess}) {
    loadingController.startLoading();
    CustomerModel.register(
      registerModel: CustomerRegisterModel(
        avatar: imagePickerController.value.fileBase64Compresed,
        nik: nikController.text,
        genderId: gender?.id,
        fullName: fullnameController.text,
        cityId: city?.id,
        phoneNumber: phonenumberController.text.replaceFirst("0", "+62"),
        username: usernameController.text,
        password: passwordController.text,
        deviceId: System.data.global.mmassagingToken,
      ),
    ).then((value) {
      loadingController.stopLoading(
        message: "${value?.toJson()}",
        isError: false,
      );
    }).catchError(
      (onError) {
        loadingController.stopLoading(
          message: ErrorHandlingUtil.handleApiError(onError),
          isError: true,
        );
      },
    );
  }

  void commit() {
    notifyListeners();
  }
}
