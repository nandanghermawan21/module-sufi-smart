import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sufismart/component/basic_component.dart';
import 'package:sufismart/model/city_model.dart';
import 'package:sufismart/model/gender_model.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/view_model/signup_view_model.dart';

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

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
          appBar: BasicComponent.appBar(),
          body: Consumer<SignupViewModel>(
            builder: (c, d, w) {
              return Container(
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
                      city(),
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
              );
            },
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
    return Container(
      height: 120,
      width: 120,
      color: Colors.orange,
    );
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
            child: gender(),
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
        ),
      ),
    );
  }

  Widget gender() {
    return Container(
      height: 50,
      color: Colors.transparent,
      padding: const EdgeInsets.all(0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(signupViewModel.genders.length, (index) {
          return Expanded(
            child: Row(
              children: [
                Radio<GenderModel>(
                  value: signupViewModel.genders[index],
                  onChanged: (val) {
                    signupViewModel.gender = signupViewModel.genders[index];
                  },
                  activeColor: System.data.color!.primaryColor,
                  groupValue: signupViewModel.gender,
                ),
                Expanded(
                  child: Container(
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      height: 15,
                      color: Colors.transparent,
                      child: FittedBox(
                        child: Text(signupViewModel.genders[index].name ?? ""),
                      )),
                ),
              ],
            ),
          );
        }),
      ),
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

  Widget city() {
    return Container(
      width: double.infinity,
      height: 50,
      color: Colors.transparent,
      child: DropdownButton<CityModel>(
        underline: Container(
          height: 1,
          color: System.data.color!.primaryColor,
        ),
        isExpanded: true,
        hint: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              System.data.strings!.chooseArea,
            ),
          ],
        ),
        value: signupViewModel.city,
        items: List.generate(signupViewModel.citys.length, (index) {
          return DropdownMenuItem<CityModel>(
              value: signupViewModel.citys[index],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(signupViewModel.citys[index].name ?? ""),
                ],
              ));
        }),
        onChanged: (area) {
          signupViewModel.city = area;
        },
      ),
    );
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
        controller: signupViewModel.nikController,
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
        onPressed: () {},
        child: Text(System.data.strings!.signUp),
      ),
    );
  }
}
