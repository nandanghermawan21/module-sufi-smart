import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sufismart/component/circular_loader_component.dart';
import 'package:sufismart/component/pin_component.dart';
import 'package:sufismart/model/customernew_model.dart';
import 'package:sufismart/model/otp_new_model.dart';
import 'package:sufismart/model/user_model.dart';
import 'package:sufismart/util/error_handling_util.dart';

import 'package:sufismart/util/system.dart';

class LoginViewModel extends ChangeNotifier {
  CircularLoaderController circularLoaderController =
      CircularLoaderController();

  Future<void> onRefreshHomePage() async {
    return Future.delayed(const Duration(seconds: 5));
  }

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  PinComponentController pinComponentController = PinComponentController();
  final GlobalKey<FormState> formKeyContact = GlobalKey<FormState>();

  String? deviceId;

  bool _emailValidation = false;
  bool get emailValidation => _emailValidation;
  set setEmailValidation(bool emailValidation) {
    _emailValidation = emailValidation;
    commit();
  }

  bool _passwordValidation = false;
  bool get passwordValidation => _passwordValidation;
  set setPasswordValidation(bool passwordValidation) {
    _passwordValidation = passwordValidation;
    commit();
  }

  bool _showPassword = true;
  bool get showPassword => _showPassword;
  set setShowPassword(bool showPassword) {
    _showPassword = showPassword;
    commit();
  }

  String? _email;
  String? get email => _email;
  set email(String? value) {
    _email = value;
    commit();
  }

  String? _password;
  String? get password => _password;
  set password(String? value) {
    _password = value;
    commit();
  }

  String? validateText(String value) {
    if (!(value.length > 5) && value.isNotEmpty) {
      return "should contain more than 5 characters";
    }
    return null;
  }

  bool validLogin() {
    bool valid = false;
    valid = showPassword ? true : false;
    valid = passwordValidation ? true : false;
    return valid;
  }

  // void login({
  //   ValueChanged<CustomerModel>? onLoginSuccess,
  // }) {
  //   circularLoaderController.startLoading();
  //   CustomerModel.login(
  //     user: UserModel(
  //       username: emailTextEditingController.text,
  //       password: passwordTextEditingController.text,
  //       deviceId: System.data.global.messagingToken,
  //     ),
  //     onRequestOtp: (otp) {
  //       PinComponent.open(
  //         context: System.data.context,
  //         controller: pinComponentController,
  //         // timer: DateTime.now().toUtc().difference(otp.expired!),
  //         timer: const Duration(seconds: 5),
  //         onTapResend: (pin) {
  //           pinComponentController.value.loadingController.startLoading();
  //           OtpModel.resend(
  //                   url: System.data.apiEndPoint.url + (otp.resendUrl ?? ""))
  //               .then((otp2) {
  //             pinComponentController.value.loadingController.forceStop();
  //             pinComponentController.value.timerController.start(
  //               duration: DateTime.now().toUtc().difference(otp2!.expired!),
  //             );
  //           }).catchError(
  //             (onErrorOtp2) {
  //               pinComponentController.value.loadingController.stopLoading(
  //                   isError: true,
  //                   message: ErrorHandlingUtil.handleApiError(onErrorOtp2));
  //             },
  //           );
  //         },
  //         onTapSend: (pin) {
  //           pinComponentController.value.loadingController.startLoading();
  //           OtpModel.confirm<CustomerModel>(
  //               url: System.data.apiEndPoint.url + (otp.confirmUrl ?? ""),
  //               otp: pin,
  //               jsonReader: (json) {
  //                 return CustomerModel.fromJson(json);
  //               }).then((customer) {
  //             pinComponentController.value.loadingController.forceStop();
  //             pinComponentController.close();
  //             circularLoaderController.stopLoading(
  //                 duration: const Duration(seconds: 3),
  //                 isError: false,
  //                 message: "Login Berhasil With Otp",
  //                 onCloseCallBack: () {
  //                   if (onLoginSuccess != null) {
  //                     onLoginSuccess(customer);
  //                   }
  //                 });
  //           }).catchError((onErrorOtp3) {
  //             pinComponentController.value.loadingController.stopLoading(
  //                 isError: true,
  //                 message: ErrorHandlingUtil.handleApiError(onErrorOtp3));
  //           });
  //         },
  //       );
  //     },
  //   ).then((value) {
  //     if (value != null) {
  //       circularLoaderController.stopLoading(
  //           duration: const Duration(seconds: 3),
  //           isError: false,
  //           message: "Login Berhasil Without Otp",
  //           onCloseCallBack: () {
  //             if (onLoginSuccess != null) {
  //               onLoginSuccess(value);
  //             }
  //           });
  //     } else {
  //       circularLoaderController.forceStop();
  //     }
  //   }).catchError((onError) {
  //     circularLoaderController.stopLoading(
  //         duration: const Duration(seconds: 3),
  //         isError: true,
  //         message: ErrorHandlingUtil.handleApiError(onError));
  //   });

  //   // emailTextEditingController.text.isEmpty
  //   //     ? setEmailValidation = true
  //   //     : setEmailValidation = false;
  //   // passwordTextEditingController.text.isEmpty
  //   //     ? setPasswordValidation = true
  //   //     : setPasswordValidation = false;
  // }

  // Future<String> getInfoDevice() {
  //   return Permission.phone.isGranted.then((granted) async {
  //     if (granted == true) {
  //       return DeviceInformation.deviceModel.then((value) {
  //         return value;
  //       });
  //     } else {
  //       return "";
  //     }
  //   }).catchError((onError) {
  //     throw onError;
  //   });
  //   //return DeviceInformation.deviceIMEINumber;
  // }

  // String? getPlatform(){
  //   if (Platform.isAndroid){
  //     return Platform.operatingSystem;
  //     //return "ANDROID";
  //   }else if(Platform.isIOS){
  //     //return "IOS";
  //     return Platform.operatingSystem;
  //   }
  //   return Platform.operatingSystem;

  // }

  void login2({
    ValueChanged<CustomerNewModel>? onLoginSuccess2,
  }) {
    circularLoaderController.startLoading();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat("yyyy-MM-dd HH:mm:ss").format(now);
    // ModeUtil.debugPrint(emailTextEditingController.text);
    // ModeUtil.debugPrint(passwordTextEditingController.text);
    // ModeUtil.debugPrint(formattedDate);
    // ModeUtil.debugPrint(DateTime.now().toUtc().difference(DateTime.parse('2023-01-23 12::55.755')) * -1);
    if (emailTextEditingController.text.isEmpty &&
        passwordTextEditingController.text.isEmpty) {
      String msg = "email dan kata sandi wajib di isi";
      circularLoaderController.stopLoading(
          duration: const Duration(seconds: 3),
          isError: true,
          message: ErrorHandlingUtil.handleApiError(msg));
    } else {
      // getPlatform.then((imei) {
      //deviceId = value.toString();
      //ModeUtil.debugPrint(imei.toString());
      CustomerNewModel.login(
          user: UserModel(
        username: emailTextEditingController.text,
        password: passwordTextEditingController.text,
        deviceId: Platform.operatingSystem,
        playerid: System.data.global.messagingToken,
        version: System.data.strings!.versiapk,
        jamdevice: formattedDate,
      )).then((value) {
        if (value != null) {
          if (value.status == "1") {
            if (value.flagotp == "1") {
              circularLoaderController.forceStop();
              PinComponent.open(
                  context: System.data.context,
                  controller: pinComponentController,
                  title: "Input OTP",
                  timer: DateTime.now().toUtc().difference(value.expired!) * -1,
                  onTapResend: (val) {
                    pinComponentController.value.loadingController
                        .startLoading();
                    DateTime nowresend = DateTime.now();
                    String formattedDate2 =
                        DateFormat("yyyy-MM-dd HH:mm:ss").format(nowresend);
                    // ModeUtil.debugPrint(value.userid!);
                    // ModeUtil.debugPrint(formattedDate2);
                    OtpNewModel.resendOtp(
                      userid: value.userid!,
                      flag: 'login',
                      jamdevice: formattedDate2,
                    ).then((value) {
                      pinComponentController.value.loadingController
                          .forceStop();
                      pinComponentController.value.timerController.start(
                        duration:
                            DateTime.now().toUtc().difference(value!.expired!) *
                                -1,
                      );
                    }).catchError((onError) {
                      pinComponentController.value.loadingController
                          .stopLoading(
                        isError: true,
                        message: ErrorHandlingUtil.handleApiError(onError),
                      );
                    });
                  },
                  onTapSend: (val) {
                    pinComponentController.value.loadingController
                        .startLoading();
                    OtpNewModel.confirmOtp(
                      otp: val,
                      userid: value.userid!,
                      flag: 'login',
                    ).then((value) {
                      if (value != null) {
                        if (value.status == "0") {
                          pinComponentController.value.loadingController
                              .stopLoading(
                            isError: false,
                            message: value.msg!,
                            duration: const Duration(seconds: 2),
                            onCloseCallBack: () {
                              if (onLoginSuccess2 != null) {
                                onLoginSuccess2(value);
                              }
                            },
                          );
                        } else if (value.status == "1") {
                          pinComponentController.value.loadingController
                              .stopLoading(
                            isError: true,
                            duration: const Duration(seconds: 2),
                            message:
                                ErrorHandlingUtil.handleApiError(value.msg!),
                          );
                        }
                      }
                    }).catchError((onError) {
                      pinComponentController.value.loadingController
                          .stopLoading(
                              isError: true,
                              message:
                                  ErrorHandlingUtil.handleApiError(onError));
                    });
                  });
            } else if (value.flagotp == "0") {
              circularLoaderController.stopLoading(
                duration: const Duration(seconds: 3),
                isError: false,
                message: value.msg,
                onCloseCallBack: () {
                  if (onLoginSuccess2 != null) {
                    onLoginSuccess2(value);
                  }
                },
              );
            }
          } else if (value.status == "2") {
            circularLoaderController.stopLoading(
              duration: const Duration(seconds: 3),
              isError: true,
              message: ErrorHandlingUtil.handleApiError(value.msg),
            );
          } else if (value.status == "3") {
            circularLoaderController.stopLoading(
              duration: const Duration(seconds: 3),
              isError: true,
              message: ErrorHandlingUtil.handleApiError(value.msg),
            );
          } else {
            circularLoaderController.stopLoading(
              duration: const Duration(seconds: 3),
              isError: true,
              message: ErrorHandlingUtil.handleApiError(value.msg),
            );
          }
        } else {
          circularLoaderController.forceStop();
        }
      }).catchError((onError) {
        circularLoaderController.stopLoading(
            duration: const Duration(seconds: 3),
            isError: true,
            message: ErrorHandlingUtil.handleApiError(onError));
      });
    }
  }

  void commit() {
    notifyListeners();
  }
}
