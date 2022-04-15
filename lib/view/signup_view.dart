import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:sufismart/component/basic_component.dart';
import 'package:sufismart/component/cilcular_loader_component.dart';
import 'package:sufismart/component/image_picker_component.dart';
import 'package:sufismart/model/city_model.dart';
import 'package:sufismart/model/customer_model.dart';
import 'package:sufismart/model/gender_model.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/view_model/signup_view_model.dart';
import 'package:http/http.dart' as http;

class SignupView extends StatefulWidget {
  final ValueChanged<CustomerModel>? onRegisterSucces;

  const SignupView({
    Key? key,
    this.onRegisterSucces,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SignupViewState();
  }
}

class _SignupViewState extends State<SignupView> {
  SignupViewModel signupViewModel = SignupViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignupViewModel>.value(
      value: signupViewModel,
      builder: (c, w) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: BasicComponent.appBar(),
          body: CircularLoaderComponent(
            controller: signupViewModel.loadingController,
            child: Container(
              padding: const EdgeInsets.all(20),
              height: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    header(),
                    const SizedBox(
                      height: 10,
                    ),
                    group1(),
                    const SizedBox(
                      height: 10,
                    ),
                    fullName(),
                    const SizedBox(
                      height: 10,
                    ),
                    cityFuture(),
                    const SizedBox(
                      height: 10,
                    ),
                    phoneNumber(),
                    const SizedBox(
                      height: 10,
                    ),
                    username(),
                    const SizedBox(
                      height: 10,
                    ),
                    password(),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: bottomNavigationBar(),
        );
      },
    );
  }

  Widget header() {
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            System.data.strings!.registration,
            style: TextStyle(
              color: System.data.color!.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            System.data.strings!.pleaseCompleteYourAccountInformation,
            style: TextStyle(
              color: System.data.color!.primaryColor,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget group1() {
    return Container(
      height: 150,
      color: Colors.transparent,
      child: Row(
        children: [
          imagePicker(),
          Expanded(
            child: group2(),
          )
        ],
      ),
    );
  }

  Widget imagePicker() {
    return ImagePickerComponent(
        controller: signupViewModel.imagePickerController);
  }

  Widget group2() {
    return Container(
      height: 120,
      color: Colors.transparent,
      child: Column(
        children: [
          nik(),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: Container(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Container(
                    child: genderFuture(),
                  )),
                  ValueListenableBuilder(
                    valueListenable: signupViewModel.imageKtpPickerController,
                    builder: (c, d, w) {
                      return Container(
                          width: 100,
                          color: Colors.transparent,
                          child: signupViewModel.imageKtpPickerController.value
                                      .imagePickerState ==
                                  ImagePickerState.loaded
                              ? Image.memory(signupViewModel
                                  .imageKtpPickerController.value.fileUri!
                                  .contentAsBytes())
                              : const SizedBox());
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget nik() {
    return Container(
      height: 50,
      padding: const EdgeInsets.only(left: 12),
      color: Colors.transparent,
      child: TextField(
        controller: signupViewModel.nikController,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
        ],
        onChanged: (val) {
          signupViewModel.nik = val;
        },
        decoration: InputDecoration(
          hintText: System.data.strings!.nIK,
          focusedBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: System.data.color!.primaryColor, width: 1.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: System.data.color!.primaryColor, width: 1.0),
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              signupViewModel.onTapScanKtp();
            },
            child: Container(
              color: Colors.transparent,
              width: 40,
              child: const Icon(
                FontAwesomeIcons.idCard,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget gender(List<GenderModel> genders) {
    return Container(
      height: 50,
      color: Colors.transparent,
      padding: const EdgeInsets.all(0),
      child: Consumer<SignupViewModel>(
        builder: (c, d, w) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(genders.length, (index) {
              return Expanded(
                child: Row(
                  children: [
                    Radio<String?>(
                      value: genders[index].id,
                      onChanged: (val) {
                        signupViewModel.gender = genders[index];
                      },
                      activeColor: System.data.color!.primaryColor,
                      groupValue: signupViewModel.gender?.id,
                    ),
                    Expanded(
                      child: Container(
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          height: 15,
                          color: Colors.transparent,
                          child: FittedBox(
                            child: Text(genders[index].name ?? ""),
                          )),
                    ),
                  ],
                ),
              );
            }),
          );
        },
      ),
    );
  }

  Widget genderFuture() {
    return FutureBuilder<List<GenderModel>>(
      future: GenderModel.getAll(),
      initialData: const [],
      builder: (ctx, snipset) {
        if (snipset.hasData) {
          return gender(snipset.data ?? []);
        } else if (snipset.hasError) {
          return Container(
            color: Colors.transparent,
            padding: const EdgeInsets.all(20),
            height: 50,
            child: Text(
              snipset.error.toString(),
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

  Widget fullName() {
    return Container(
      width: double.infinity,
      height: 50,
      color: Colors.transparent,
      child: TextField(
        controller: signupViewModel.fullnameController,
        keyboardType: TextInputType.text,
        onChanged: (val) {
          signupViewModel.fullname = val;
        },
        decoration: InputDecoration(
          hintText: System.data.strings!.fullname,
          focusedBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: System.data.color!.primaryColor, width: 1.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: System.data.color!.primaryColor, width: 1.0),
          ),
        ),
      ),
    );
  }

  Widget cityFuture() {
    return FutureBuilder<List<CityModel>>(
      future: signupViewModel.cities,
      initialData: const [],
      builder: (ctx, snap) {
        if (snap.hasData) {
          return city(snap.data ?? []);
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

  Widget city(List<CityModel> cities) {
    return Consumer<SignupViewModel>(builder: (c, d, w) {
      return Container(
        width: double.infinity,
        height: 50,
        color: Colors.transparent,
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
                System.data.strings!.city,
              ),
            ],
          ),
          value: signupViewModel.city?.id,
          items: List.generate(cities.length, (index) {
            return DropdownMenuItem<String?>(
                value: cities[index].id,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(cities[index].name ?? ""),
                  ],
                ));
          }),
          onChanged: (area) {
            signupViewModel.city = cities.where((e) => e.id == area).first;
          },
        ),
      );
    });
  }

  Widget phoneNumber() {
    return Container(
      width: double.infinity,
      height: 50,
      color: Colors.transparent,
      child: TextField(
        controller: signupViewModel.phonenumberController,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
        ],
        onChanged: (val) {
          signupViewModel.phonenumber = val;
        },
        decoration: InputDecoration(
          hintText: System.data.strings!.phoneNumber,
          focusedBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: System.data.color!.primaryColor, width: 1.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: System.data.color!.primaryColor, width: 1.0),
          ),
        ),
      ),
    );
  }

  Widget username() {
    return Container(
      width: double.infinity,
      height: 50,
      color: Colors.transparent,
      child: TextField(
        controller: signupViewModel.usernameController,
        keyboardType: TextInputType.text,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp("[0-9A-Za-z]")),
        ],
        onChanged: (val) {
          signupViewModel.username = val;
        },
        decoration: InputDecoration(
          hintText: System.data.strings!.username,
          focusedBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: System.data.color!.primaryColor, width: 1.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: System.data.color!.primaryColor, width: 1.0),
          ),
        ),
      ),
    );
  }

  Widget password() {
    return Container(
      width: double.infinity,
      height: 50,
      color: Colors.transparent,
      child: TextField(
        controller: signupViewModel.passwordController,
        obscureText: true,
        keyboardType: TextInputType.text,
        onChanged: (val) {
          signupViewModel.password = val;
        },
        decoration: InputDecoration(
          hintText: System.data.strings!.password,
          focusedBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: System.data.color!.primaryColor, width: 1.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: System.data.color!.primaryColor, width: 1.0),
          ),
        ),
      ),
    );
  }

  Widget bottomNavigationBar() {
    return Container(
      margin: const EdgeInsets.all(15),
      color: Colors.transparent,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(System.data.color!.primaryColor)),
        onPressed: () {
          signupViewModel.register(
            onRegisterSuccess: widget.onRegisterSucces,
          );
        },
        child: Text(System.data.strings!.signUp),
      ),
    );
  }
}
