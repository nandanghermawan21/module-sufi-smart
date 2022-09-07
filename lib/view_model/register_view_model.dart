import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sufismart/component/circular_loader_component.dart';
import 'package:sufismart/component/pin_component.dart';
import 'package:sufismart/model/customer_register_new_model.dart';
import 'package:sufismart/model/customernew_model.dart';
import 'package:sufismart/model/gendernew_model.dart';
import 'package:sufismart/model/job_model.dart';
import 'package:sufismart/model/otp_new_model.dart';
import 'package:sufismart/util/error_handling_util.dart';
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';

class RegisterViewModel extends ChangeNotifier {
  CircularLoaderController loadingController = CircularLoaderController();
  PinComponentController pinComponentController = PinComponentController();

  Future<List<JobModel>?> jobs = JobModel.getListJob();
  Future<List<GenderNewModel>?> genders = GenderNewModel.getListGender();

  final GlobalKey<FormState> formKeyContact = GlobalKey<FormState>();

  DateTime? selectedDateFrom = DateTime.now();
  DateTime? picked;
  Duration? timertest;
  final format = DateFormat("yyyy-MM-dd");

  TextEditingController namaTextController = TextEditingController();
  TextEditingController tanggalLahirTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController noTelpTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  bool _showPassword = true;
  bool get showPassword => _showPassword;
  set setShowPassword(bool showPassword) {
    _showPassword = showPassword;
    commit();
  }

  GenderNewModel? _gender;
  GenderNewModel? get gender => _gender;
  set gender(GenderNewModel? type) {
    _gender = type;
    commit();
  }

  JobModel? _job;
  JobModel? get job => _job;
  set job(JobModel? type) {
    _job = type;
    commit();
  }

  String? _fullname;
  String? get fullname => _fullname;
  set fullname(String? value) {
    _fullname = value;
    commit();
  }

  String? _email;
  String? get email => _email;
  set email(String? value) {
    _email = value;
    commit();
  }

  String? _tanggallahir;
  String? get tanggallahir => _tanggallahir;
  set tanggallahir(String? value) {
    _tanggallahir = value;
    commit();
  }

  String? _telp;
  String? get telp => _telp;
  set telp(String? value) {
    _telp = value;
    commit();
  }

  String? _password;
  String? get password => _password;
  set password(String? value) {
    _password = value;
    commit();
  }

  void showDate() async {
    picked = await showDatePicker(
        context: System.data.context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 200, 1),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDateFrom) {
      selectedDateFrom = picked!;
      tanggalLahirTextController.text = format.format(selectedDateFrom!);
      ModeUtil.debugPrint("tgllahir $tanggallahir");
      commit();
    }
  }

  void sendRegistrasi({ValueChanged<CustomerNewModel>? onRegisterSuccess}) {
    loadingController.startLoading();
    // ModeUtil.debugPrint("nama, " + namaTextController.text);
    // ModeUtil.debugPrint("email, " + emailTextController.text);
    // ModeUtil.debugPrint("notelp, " + noTelpTextController.text);
    // ModeUtil.debugPrint("tgllahir, " + tanggalLahirTextController.text);
    // ModeUtil.debugPrint("password, " + passwordTextController.text);
    // ModeUtil.debugPrint("job, ${job?.value}");
    // ModeUtil.debugPrint("gender, ${gender?.value}");
    // ModeUtil.debugPrint("token, ${System.data.global.messagingToken}");
    // ModeUtil.debugPrint("paltform, ${Platform.operatingSystem}");

    CustomerRegisterNewModel.sendRegistrasi(
            customerRegisterNewModel: CustomerRegisterNewModel(
                namalengkap: namaTextController.text,
                nohp: noTelpTextController.text,
                email: emailTextController.text,
                pass: passwordTextController.text,
                tanggallahir: tanggalLahirTextController.text,
                pekerjaan: job?.value,
                gender: gender?.value,
                deviceplatform: Platform.operatingSystem,
                token: System.data.global.messagingToken,
                version: System.data.strings!.versiapk))
        .then((otp) {
      if (otp != null) {
        if (otp.status == "0") {
          loadingController.stopLoading(
            isError: false,
            message: otp.message!,
            duration: const Duration(seconds: 2),
            onCloseCallBack: () {
              // if (onRegisterSuccess != null) {
              //   onRegisterSuccess(value);
              // }
            },
          );
          PinComponent.open(
              context: System.data.context,
              controller: pinComponentController,
              title: "Input OTP",
              timer: DateTime.now().toUtc().difference(otp.expired!) * -1,
              onTapResend: (val) {
                pinComponentController.value.loadingController.startLoading();
                OtpNewModel.resendOtp(
                  userid: otp.userid!, flag: 'regis',
                ).then((value) {
                  pinComponentController.value.loadingController.forceStop();
                  pinComponentController.value.timerController.start(
                    duration:
                        DateTime.now().toUtc().difference(value!.expired!) * -1,
                  );
                }).catchError((onError) {
                  pinComponentController.value.loadingController.stopLoading(
                    isError: true,
                    message: ErrorHandlingUtil.handleApiError(onError),
                  );
                });
              },
              onTapSend: (val) {
                pinComponentController.value.loadingController.startLoading();
                OtpNewModel.confirmOtp(
                  otp: val,
                  userid: otp.userid!, flag: 'regis',
                ).then((value) {
                  if (value != null) {
                    if (value.status == "0") {
                      pinComponentController.value.loadingController
                          .stopLoading(
                        isError: false,
                        message: value.msg!,
                        duration: const Duration(seconds: 2),
                        onCloseCallBack: () {
                          if (onRegisterSuccess != null) {
                            onRegisterSuccess(value);
                          }
                        },
                      );
                    } else if (value.status == "1") {
                      pinComponentController.value.loadingController
                          .stopLoading(
                        isError: true,
                        duration: const Duration(seconds: 3),
                        message: ErrorHandlingUtil.handleApiError(value.msg!),
                      );
                    }
                  }
                }).catchError((onError) {
                  pinComponentController.value.loadingController.stopLoading(
                      isError: true,
                      message: ErrorHandlingUtil.handleApiError(onError));
                });

                ModeUtil.debugPrint("OnTapSend");
              });
          // loadingController.stopLoading(
          //   duration: const Duration(seconds: 5),
          //   isError: false,
          //   message: otp.message,
          //   onCloseCallBack: () {
          //     //
          //   },
          // );
        } else if (otp.status == "1") {
          loadingController.stopLoading(
              duration: const Duration(seconds: 3),
              isError: true,
              message: ErrorHandlingUtil.handleApiError(otp.message));
        }
      }
    }).catchError((onError) {
      loadingController.stopLoading(
          duration: const Duration(seconds: 3),
          isError: true,
          message: ErrorHandlingUtil.handleApiError(onError));
    });

    // loadingController.forceStop();
    // PinComponent.open(
    //     context: System.data.context,
    //     controller: pinComponentController,
    //     title: "Input OTP",
    //     timer: DateTime.now().toUtc().difference(DateTime.now()) * -1,
    //     onTapResend: (val) {
    //       pinComponentController.value.loadingController.startLoading();
    //       ModeUtil.debugPrint("OnTapResend " + val);
    //     },
    //     onTapSend: (val) {
    //       pinComponentController.value.loadingController.forceStop();
    //       ModeUtil.debugPrint("OnTapSend "+val);
    //     });
  }

  void commit() {
    notifyListeners();
  }
}
