import 'package:flutter/material.dart';
import 'package:sufismart/component/image_picker_component.dart';
import 'package:sufismart/component/pin_component.dart';
import 'package:sufismart/model/city_model.dart';
import 'package:sufismart/model/customer_model.dart';
import 'package:sufismart/model/customer_register_model.dart';
import 'package:sufismart/model/gender_model.dart';
import 'package:sufismart/model/ktp_model.dart';
import 'package:sufismart/util/error_handling_util.dart';
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/component/cilcular_loader_component.dart';

class SignupViewModel extends ChangeNotifier {
  CircularLoaderController loadingController = CircularLoaderController();
  ImagePickerController imageKtpPickerController = ImagePickerController();
  PinComponentController pinComponentController = PinComponentController();

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

  void register({ValueChanged<CustomerModel>? onRegisterSuccess}) {
    loadingController.startLoading();
    CustomerModel.post(
      registerModel: CustomerRegisterModel(
        avatar: imagePickerController.value.fileBase64Compresed,
        nik: nikController.text,
        genderId: gender?.id,
        fullName: fullnameController.text,
        cityId: city?.id,
        phoneNumber: phonenumberController.text.replaceFirst("0", "+62"),
        username: usernameController.text,
        password: passwordController.text,
        deviceId: System.data.global.messagingToken,
      ),
    ).then((otp) {
      loadingController.forceClose();
      PinComponent.open(
          context: System.data.context,
          controller: pinComponentController,
          title: "Input OTP",
          timer: const Duration(seconds: 10),
          onTapResend: (val) {
            pinComponentController.value.loadingController.startLoading();
            OtpModel.resend(url: System.data.apiEndPoint.url + otp!.resendUrl!)
                .then(
              (value) {
                pinComponentController.value.loadingController.forceClose();
                pinComponentController.value.timerController.start(
                  duration: DateTime.now().toUtc().difference(value!.expired!),
                );
              },
            ).catchError(
              (onError) {
                pinComponentController.value.loadingController.stopLoading(
                    isError: true,
                    message: ErrorHandlingUtil.handleApiError(onError));
              },
            );
          },
          onTapSend: (val) {
            pinComponentController.value.loadingController.startLoading();
            OtpModel.confirm<CustomerModel>(
              url: System.data.apiEndPoint.url + (otp!.confirmUrl ?? ""),
              otp: val,
              jsonReader: (json) {
                return CustomerModel.fromJson(json);
              },
            ).then(
              (value) {
                loadingController.stopLoading(
                  isError: false,
                  message: "Login success",
                  duration: const Duration(seconds: 2),
                  onCloseCallBack: () {
                    if (onRegisterSuccess != null) {
                      onRegisterSuccess(value);
                    }
                  },
                );
              },
            ).catchError((onError) {
              pinComponentController.value.loadingController.stopLoading(
                  isError: true,
                  message: ErrorHandlingUtil.handleApiError(onError));
            });
          });
    }).catchError(
      (onError) {
        loadingController.stopLoading(
          message: ErrorHandlingUtil.handleApiError(onError),
          isError: true,
        );
      },
    );
  }

  void onTapScanKtp() {
    imageKtpPickerController
        .getImages(
      camera: true,
    )
        .then((value) {
      loadingController.startLoading();
      KtpModel.readFromImage(
        key: System.data.global.ocrKey,
        file: value.fileImage,
      ).then(
        (value) {
          ModeUtil.debugPrint(value.toJson());
          loadingController.stopLoading(
            isError: false,
            message:
                "${System.data.strings!.readDataKtpSuccess} \n ${value.nik}",
            onCloseCallBack: () {
              nikController.text = value.nik ?? "";
              fullnameController.text = value.nama ?? "";
              GenderModel.readGender(value.jenisKelamin ?? "").then((value) {
                gender = value;
              });
              CityModel.readCity(value.kotaKabupaten ?? "").then((value) {
                city = value;
              });
            },
          );
        },
      ).catchError((onError) {
        loadingController.stopLoading(
          message: ErrorHandlingUtil.handleApiError(onError),
          isError: true,
        );
      });
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
