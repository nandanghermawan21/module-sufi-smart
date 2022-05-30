import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:sufismart/component/circular_loader_component.dart';
import 'package:sufismart/model/customernew_model.dart';
import 'package:sufismart/model/gendernew_model.dart';
import 'package:sufismart/model/job_model.dart';
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/view_model/register_view_model.dart';
import 'package:http/http.dart' as http;

class RegisterView extends StatefulWidget {
  final ValueChanged<CustomerNewModel>? onRegisterSucces;
  const RegisterView({
    Key? key,
    this.onRegisterSucces,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RegisterViewState();
  }
}

class _RegisterViewState extends State<RegisterView> {
  RegisterViewModel registerViewModel = RegisterViewModel();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: registerViewModel,
      child: Scaffold(
        appBar: appBar(),
        body: CircularLoaderComponent(
          controller: registerViewModel.loadingController,
          child: SingleChildScrollView(
            child: Consumer<RegisterViewModel>(
              builder: (c, d, w) {
                return Container(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Container(
                        color: Colors.transparent,
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          System.data.strings!.registration,
                          style: TextStyle(
                              color: System.data.color!.primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          System.data.strings!
                              .pleaseCompleteYourAccountInformation,
                          style: TextStyle(
                            color: System.data.color!.primaryColor,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Form(
                        key: registerViewModel.formKeyContact,
                        autovalidateMode: AutovalidateMode.always,
                        child: Container(
                          color: Colors.transparent,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              fullname(),
                              const SizedBox(
                                height: 10,
                              ),
                              telp(),
                              const SizedBox(
                                height: 10,
                              ),
                              email(),
                              const SizedBox(
                                height: 10,
                              ),
                              tanggalLahir(),
                              const SizedBox(
                                height: 10,
                              ),
                              password(),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                color: Colors.transparent,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(System.data.strings!.gender),
                                    genderFuture(),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                color: Colors.transparent,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(System.data.strings!.job),
                                    jobFuture(),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              buttonSubmit()
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: System.data.color!.mainColor,
      title: Image.asset(
        "assets/logo_sfi_white.png",
        fit: BoxFit.cover,
        height: 30,
      ),
    );
  }

  Widget buttonSubmit() {
    return GestureDetector(
      onTap: () {
        if (registerViewModel.formKeyContact.currentState!.validate()) {
          // ModeUtil.debugPrint(
          //     "homeViewModel.formKeyContact.currentState ${registerViewModel.formKeyContact.currentState}");
          ModeUtil.debugPrint("masuk");
          registerViewModel.sendRegistrasi(
            onRegisterSuccess: widget.onRegisterSucces,
          );
          //registerViewModel.sendRegistrasi();
        }
      },
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            color: System.data.color!.primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: Center(
          child: Text(
            System.data.strings!.send,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }

  Widget fullname() {
    return TextFormField(
      controller: registerViewModel.namaTextController,
      autofocus: false,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp("[a-z A-Z]")),
      ],
      decoration: InputDecoration(
          labelText: System.data.strings!.fullname,
          labelStyle: const TextStyle(
            color: Colors.grey,
          ),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey))),
      keyboardType: TextInputType.text,
      cursorColor: Colors.grey,
      validator: (String? value) {
        if (value!.isEmpty) {
          return (System.data.strings!.fullname) +
              (" " + System.data.strings!.canNotBeEmpty);
        }
        return null;
      },
      onSaved: (String? value) {
        registerViewModel.fullname = value!;
      },
    );
  }

  Widget telp() {
    return TextFormField(
      controller: registerViewModel.noTelpTextController,
      autofocus: false,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
        LengthLimitingTextInputFormatter(14),
      ],
      decoration: InputDecoration(
          labelText: System.data.strings!.phoneNumber,
          labelStyle: const TextStyle(
            color: Colors.grey,
          ),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey))),
      keyboardType: TextInputType.phone,
      cursorColor: Colors.grey,
      validator: (String? value) {
        if (value!.isEmpty) {
          return (System.data.strings!.phoneNumber) +
              (" " + System.data.strings!.canNotBeEmpty);
        }
        return null;
      },
      onSaved: (String? value) {
        registerViewModel.telp = value!;
      },
    );
  }

  Widget tanggalLahir() {
    return TextFormField(
      controller: registerViewModel.tanggalLahirTextController,
      keyboardType: TextInputType.datetime,
      autofocus: false,
      readOnly: true,
      decoration: InputDecoration(
        labelText: System.data.strings!.birthdate,
        labelStyle: const TextStyle(
          color: Colors.grey,
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
      cursorColor: Colors.grey,
      onTap: () {
        registerViewModel.showDate();
      },
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Tanggal lahir tidak boleh kosong';
        }
        return null;
      },
      onSaved: (String? value) {
        registerViewModel.tanggallahir = value!;
      },
    );
  }

  Widget email() {
    return TextFormField(
      controller: registerViewModel.emailTextController,
      autofocus: false,
      decoration: InputDecoration(
          labelText: System.data.strings!.email,
          labelStyle: const TextStyle(
            color: Colors.grey,
          ),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey))),
      keyboardType: TextInputType.emailAddress,
      cursorColor: Colors.grey,
      validator: (String? value) {
        RegExp regex = RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
        if (value!.isEmpty) {
          return (System.data.strings!.email) +
              (" " + System.data.strings!.canNotBeEmpty);
        } else if (!regex.hasMatch(value)) {
          return System.data.strings!.enterAValidEmail;
        }
        return null;
      },
      onSaved: (String? value) {
        registerViewModel.email = value!;
      },
    );
  }

  Widget password() {
    return TextFormField(
      controller: registerViewModel.passwordTextController,
      autofocus: false,
      obscureText: registerViewModel.showPassword,
      decoration: InputDecoration(
        labelText: System.data.strings!.password,
        labelStyle: const TextStyle(
          color: Colors.grey,
        ),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
        suffixIcon: IconButton(
          onPressed: () {
            registerViewModel.setShowPassword = !registerViewModel.showPassword;
          },
          icon: Icon(
            registerViewModel.showPassword
                ? FontAwesomeIcons.eyeSlash
                : FontAwesomeIcons.eye,
          ),
        ),
      ),
      cursorColor: Colors.grey,
      validator: (String? value) {
        if (value!.isEmpty) {
          return '${System.data.strings!.password} ${System.data.strings!.cantBeEmpty}';
        } else {
          return null;
        }
      },
    );
  }

  Widget jobFuture() {
    return FutureBuilder<List<JobModel>?>(
      future: registerViewModel.jobs,
      initialData: const [],
      builder: (ctx, snap) {
        if (snap.hasData) {
          return listjob(snap.data ?? []);
        } else if (snap.hasError) {
          return Container(
            color: Colors.white,
            width: double.infinity,
            height: 50,
            child: Text(
              "can't load city : ${(snap.error as http.Response).body}",
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else {
          return SkeletonAnimation(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget listjob(List<JobModel> jobModel) {
    return Consumer<RegisterViewModel>(
      builder: (c, d, w) {
        return Container(
          color: Colors.transparent,
          width: double.infinity,
          height: 50,
          child: DropdownButton<String?>(
            underline: Container(
              height: 1,
              color: System.data.color!.primaryColor,
            ),
            isExpanded: true,
            hint: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  System.data.strings!.chooseJob,
                )
              ],
            ),
            value: registerViewModel.job?.value,
            items: List.generate(jobModel.length, (index) {
              return DropdownMenuItem<String?>(
                value: jobModel[index].value,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      jobModel[index].value ?? "",
                      style: const TextStyle(fontSize: 15),
                    )
                  ],
                ),
              );
            }),
            onChanged: (_jobvalue) {
              registerViewModel.job =
                  jobModel.where((e) => e.value == _jobvalue).first;
            },
          ),
        );
      },
    );
  }

  Widget genderFuture() {
    return FutureBuilder<List<GenderNewModel>?>(
      future: registerViewModel.genders,
      initialData: const [],
      builder: (ctx, snap) {
        if (snap.hasData) {
          return listGender(snap.data ?? []);
        } else if (snap.hasError) {
          return Container(
            color: Colors.white,
            width: double.infinity,
            height: 50,
            child: Text(
              "can't load city : ${(snap.error as http.Response).body}",
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else {
          return SkeletonAnimation(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget listGender(List<GenderNewModel> genderModel) {
    return Consumer<RegisterViewModel>(
      builder: (c, d, w) {
        return Container(
          color: Colors.transparent,
          width: double.infinity,
          height: 50,
          child: DropdownButton<String?>(
            underline: Container(
              height: 1,
              color: System.data.color!.primaryColor,
            ),
            isExpanded: true,
            hint: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  System.data.strings!.chooseGender,
                )
              ],
            ),
            value: registerViewModel.gender?.value,
            items: List.generate(genderModel.length, (index) {
              return DropdownMenuItem<String?>(
                value: genderModel[index].value,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      genderModel[index].value ?? "",
                      style: const TextStyle(fontSize: 13),
                    )
                  ],
                ),
              );
            }),
            onChanged: (_gendervalue) {
              registerViewModel.gender =
                  genderModel.where((e) => e.value == _gendervalue).first;
            },
          ),
        );
      },
    );
  }
}
