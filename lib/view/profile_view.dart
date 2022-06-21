import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:sufismart/component/circular_loader_component.dart';

import 'package:sufismart/model/customernew_model.dart';
import 'package:sufismart/model/gendernew_model.dart';
import 'package:sufismart/model/job_model.dart';
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/view_model/profile_view_model.dart';
import 'package:http/http.dart' as http;

class ProfileView extends StatefulWidget {
  const ProfileView({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProfileViewState();
  }
}

class ProfileViewState extends State<ProfileView> {
  ProfileViewModel profileViewModel = ProfileViewModel();

  @override
  void initState() {
    super.initState();
    profileViewModel.getDetailInfoUser(
        userid: System.data.global.customerNewModel?.userid ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: profileViewModel,
      child: Scaffold(
        appBar: appBar(),
        body: CircularLoaderComponent(
          controller: profileViewModel.loadingController,
          child: SingleChildScrollView(
            child: Consumer<ProfileViewModel>(
              builder: (c, d, w) {
                return Container(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          System.data.strings!.updateProfile,
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
                          System.data.strings!.descProfile,
                          style: TextStyle(
                            color: System.data.color!.primaryColor,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const Divider(),
                      Form(
                        key: profileViewModel.formKeyContact,
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
                              tanggalLahir(),
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
                              descInfoNasabah(),
                              nokon(),
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
        if (profileViewModel.formKeyContact.currentState!.validate()) {
          // ModeUtil.debugPrint(
          //     "homeViewModel.formKeyContact.currentState ${registerViewModel.formKeyContact.currentState}");
          ModeUtil.debugPrint("masuk");
          // profileViewModel.sendUpdateProfil(
          //   onUpdateSuccefuly: widget.onUpdateSuccefuly,
          // );
          // registerViewModel.sendRegistrasi(
          //   onRegisterSuccess: widget.onRegisterSucces,
          // );
          profileViewModel.sendUpdateProfil();
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

  Widget descInfoNasabah() {
    return Container(
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      child: Text(
        System.data.strings!.infoNoKontrak,
        style: TextStyle(
          color: System.data.color?.primaryColor,
          fontSize: 14,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget nokon() {
    return Column(
      children: [
        TextFormField(
          controller: profileViewModel.noKtpTextController,
          autofocus: false,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
            LengthLimitingTextInputFormatter(20),
          ],
          decoration: InputDecoration(
              labelText: System.data.strings!.noKtp,
              labelStyle: const TextStyle(
                color: Colors.grey,
              ),
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey))),
          keyboardType: TextInputType.phone,
          cursorColor: Colors.grey,
          onSaved: (String? value) {
            profileViewModel.noktp = value!;
          },
        ),
        TextFormField(
          controller: profileViewModel.noKontrak1TextController,
          autofocus: false,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
            LengthLimitingTextInputFormatter(14),
          ],
          decoration: InputDecoration(
              labelText: System.data.strings!.nomorKontrak1,
              labelStyle: const TextStyle(
                color: Colors.grey,
              ),
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey))),
          keyboardType: TextInputType.phone,
          cursorColor: Colors.grey,
          onSaved: (String? value) {
            profileViewModel.nokon1 = value!;
          },
        ),
        TextFormField(
          controller: profileViewModel.noKontrak2TextController,
          autofocus: false,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
            LengthLimitingTextInputFormatter(14),
          ],
          decoration: InputDecoration(
              labelText: System.data.strings!.nomorKontrak2,
              labelStyle: const TextStyle(
                color: Colors.grey,
              ),
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey))),
          keyboardType: TextInputType.phone,
          cursorColor: Colors.grey,
          onSaved: (String? value) {
            profileViewModel.nokon2 = value!;
          },
        ),
        TextFormField(
          controller: profileViewModel.noKontrak3TextController,
          autofocus: false,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
            LengthLimitingTextInputFormatter(14),
          ],
          decoration: InputDecoration(
              labelText: System.data.strings!.nomorKontrak3,
              labelStyle: const TextStyle(
                color: Colors.grey,
              ),
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey))),
          keyboardType: TextInputType.phone,
          cursorColor: Colors.grey,
          onSaved: (String? value) {
            profileViewModel.nokon3 = value!;
          },
        ),
      ],
    );
  }

  Widget fullname() {
    return TextFormField(
      controller: profileViewModel.namaTextController,
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
        profileViewModel.fullname = value!;
      },
    );
  }

  Widget telp() {
    return TextFormField(
      controller: profileViewModel.noTelpTextController,
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
        profileViewModel.telp = value!;
      },
    );
  }

  Widget tanggalLahir() {
    return TextFormField(
      controller: profileViewModel.tanggalLahirTextController,
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
        profileViewModel.showDate();
      },
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Tanggal lahir tidak boleh kosong';
        }
        return null;
      },
      onSaved: (String? value) {
        profileViewModel.tanggallahir = value!;
      },
    );
  }

  Widget jobFuture() {
    return FutureBuilder<List<JobModel>?>(
      future: profileViewModel.jobs,
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
    return Consumer<ProfileViewModel>(
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
            value: profileViewModel.job?.value,
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
              profileViewModel.job =
                  jobModel.where((e) => e.value == _jobvalue).first;
            },
          ),
        );
      },
    );
  }

  Widget genderFuture() {
    return FutureBuilder<List<GenderNewModel>?>(
      future: profileViewModel.genders,
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
    return Consumer<ProfileViewModel>(
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
            value: profileViewModel.gender?.value,
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
              profileViewModel.gender =
                  genderModel.where((e) => e.value == _gendervalue).first;
            },
          ),
        );
      },
    );
  }
}
