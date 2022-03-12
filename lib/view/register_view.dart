import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sufismart/model/gender_type_model.dart';
import 'package:sufismart/model/kota_model.dart';
import 'package:sufismart/model/user_model.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/view_model/auth_view_model.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RegisterState();
  }
}

class _RegisterState extends State<RegisterView> {
  AuthViewModel authViewModel = AuthViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: authViewModel,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Consumer<AuthViewModel>(
            builder: (c, d, w) => registWidget(context, authViewModel),
          ),
        ),
      ),
    );
  }
}

Widget registWidget(BuildContext context, AuthViewModel authViewModel) {
  UserModel userModel = UserModel();

  return Container(
    margin: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 5),
          width: MediaQuery.of(context).size.width,
          child: Text(
            System.data.strings!.regist,
            style: TextStyle(
                color: System.data.color!.primaryColor,
                fontSize: 24,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          width: MediaQuery.of(context).size.width,
          child: Text(
            System.data.strings!.completeInfo,
            style: TextStyle(
              color: System.data.color!.primaryColor,
              fontSize: 16,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Image.asset(
                    'assets/camera.png',
                    height: 100.0,
                    width: 150.0,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      Container(
                        width: 200,
                        height: 30,
                        color: Colors.transparent,
                        child: Container(
                          width: double.infinity,
                          color: Colors.transparent,
                          child: TextField(
                            onChanged: (text) {
                              userModel.countryId = text;
                            },
                            decoration: InputDecoration(
                              hintText: '${System.data.strings!.registNoKTP}',
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: System.data.color!.primaryColor,
                                    width: 1.0),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: System.data.color!.primaryColor,
                                    width: 1.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 200,
                        height: 50,
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(authViewModel.genders.length,
                              (index) {
                            return Expanded(
                              child: Row(
                                children: [
                                  Radio<GenderModel>(
                                    value: authViewModel.genders[index],
                                    onChanged: (val) {
                                      authViewModel.gender =
                                          authViewModel.genders[index];
                                      userModel.gender =
                                          authViewModel.genders[index].name;
                                    },
                                    activeColor:
                                        System.data.color!.primaryColor,
                                    groupValue: authViewModel.gender,
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: double.infinity,
                                      height: 15,
                                      color: Colors.transparent,
                                      child: Text(
                                        authViewModel.genders[index].name ?? "",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
        TextField(
          onChanged: (text) {
            userModel.fullName = text;
          },
          decoration: InputDecoration(
            hintText: System.data.strings!.registFullName,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: System.data.color!.primaryColor, width: 1.0),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: System.data.color!.primaryColor, width: 1.0),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        DropdownButton<KotaModel>(
          underline: Container(
            height: 1,
            color: System.data.color!.primaryColor,
          ),
          isExpanded: true,
          hint: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                System.data.strings!.chooseCity,
              ),
            ],
          ),
          value: authViewModel.kota,
          items: List.generate(authViewModel.city.length, (index) {
            return DropdownMenuItem<KotaModel>(
                value: authViewModel.city[index],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(authViewModel.city[index].name ?? ""),
                  ],
                ));
          }),
          onChanged: (kota) {
            authViewModel.kota = kota;
            userModel.cityName = kota?.name;
          },
        ),
        TextField(
          onChanged: (text) {
            userModel.phoneNumber = text;
          },
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              hintText: System.data.strings!.registPhoneNumber,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: System.data.color!.primaryColor, width: 1.0),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: System.data.color!.primaryColor, width: 1.0),
              ),
              isDense: true),
        ),
        TextField(
          onChanged: (text) {
            userModel.userName = text;
          },
          decoration: InputDecoration(
            hintText: System.data.strings!.registUserName,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: System.data.color!.primaryColor, width: 1.0),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: System.data.color!.primaryColor, width: 1.0),
            ),
          ),
        ),
        TextField(
          onChanged: (text) {
            userModel.userPass = text;
          },
          controller: authViewModel.passwordTextEditingController,
          obscureText: authViewModel.showPassword,
          decoration: InputDecoration(
            hintText: System.data.strings!.registUserPass,
            errorText: authViewModel.passwordValidation
                ? '${System.data.strings!.password} ${System.data.strings!.cantBeEmpty}'
                : null,
            suffixIcon: IconButton(
              onPressed: () {
                authViewModel.setShowPassword = !authViewModel.showPassword;
              },
              icon: Icon(
                authViewModel.showPassword
                    ? FontAwesomeIcons.eye
                    : FontAwesomeIcons.eyeSlash,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => authViewModel.regist(userModel),
          child: Container(
            height: 50,
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 10, top: 30),
            decoration: BoxDecoration(
                color: System.data.color!.primaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: Center(
              child: Text(
                System.data.strings!.regist2,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
