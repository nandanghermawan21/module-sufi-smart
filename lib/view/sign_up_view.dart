import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sufismart/component/basic_component.dart';
import 'package:sufismart/model/gender_model.dart';
import 'package:sufismart/model/kota_model.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/view_model/sign_up_view_model.dart';

class SignUpView extends StatefulWidget {
  final VoidCallback? gotoProfile;
  const SignUpView({
    Key? key,
    this.gotoProfile,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUpView> {
  SignUpViewModel signupViewModel = SignUpViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: signupViewModel,
      child: Scaffold(
        appBar: BasicComponent.appBar(),
        body: SingleChildScrollView(
          child: Consumer<SignUpViewModel>(
            builder: (c, d, w) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      System.data.strings!.registration.replaceAll("\n", " "),
                      style: TextStyle(
                        fontSize: 22,
                        color: System.data.color!.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      System.data.strings!.pleaseCompleteYourAccount
                          .replaceAll("\n", " "),
                      style: TextStyle(
                          fontSize: 15,
                          color: System.data.color!.primaryColor,
                          fontWeight: FontWeight.normal,
                          wordSpacing: 2),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: imgKtp(),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        // Container(
                        //   width: 100,
                        //   color: Colors.transparent,
                        //   child: ketKtp(),
                        // )
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: noKtp(),
                          ),
                        ),
                      ],
                    ),
                    namaLengkap(),
                    const SizedBox(
                      height: 10,
                    ),
                    kota(),
                    const SizedBox(
                      height: 10,
                    ),
                    noTelp(),
                    const SizedBox(
                      height: 10,
                    ),
                    namaPengguna(),
                    const SizedBox(
                      height: 10,
                    ),
                    kataSandi(),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              );
            },
          ),
        ),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.all(15),
          color: Colors.transparent,
          height: 50,
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(System.data.color!.primaryColor)),
            onPressed: () {
              widget.gotoProfile!();
            },
            child: Text(System.data.strings!.daftar),
          ),
        ),
      ),
    );
  }

  Widget photo() {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      width: 120,
      height: 110,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.camera_alt_outlined,
            size: 70,
          ),
        ],
      ),
    );
  }

  Widget imgKtp() {
    return Container(
      height: 120,
      child: Container(
        height: MediaQuery.of(context).size.height / 2,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          // image: const DecorationImage(
          //     scale: 3.0,
          //     alignment: Alignment.center,
          //     image: AssetImage('assets/icon_foto.png')),
          border: Border.all(style: BorderStyle.solid),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.camera_alt,
              size: 80,
            ),
          ],
        ),
      ),
    );
  }

  Widget noKtp() {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(left: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20),
            child: TextField(
              controller: signupViewModel.noKtpTextEditingController,
              decoration: InputDecoration(
                labelText: System.data.strings!.noKtp,
                errorText: signupViewModel.noKtp
                    ? '${System.data.strings!.noKtp} ${System.data.strings!.cantBeEmpty}'
                    : null,
              ),
            ),
          ),
          Container(
            height: 80,
            //color: Colors.red,
            //margin: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(signupViewModel.genders.length, (index) {
                return Expanded(
                  child: Row(
                    children: [
                      Radio<GenderModel>(
                          value: signupViewModel.genders[index],
                          onChanged: (val) {
                            signupViewModel.gender =
                                signupViewModel.genders[index];
                          },
                          activeColor: System.data.color!.primaryColor,
                          groupValue: signupViewModel.gender),
                      Expanded(
                        child: Container(
                            alignment: Alignment.centerLeft,
                            width: double.infinity,
                            height: 20,
                            color: Colors.transparent,
                            child: FittedBox(
                              child: Text(
                                signupViewModel.genders[index].name ?? "",
                                style: const TextStyle(fontSize: 20),
                              ),
                            )),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget namaLengkap() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: signupViewModel.namaLengkapTextEditingController,
            decoration: InputDecoration(
              labelText: System.data.strings!.fullname,
              errorText: signupViewModel.namaLengkap
                  ? '${System.data.strings!.fullname} ${System.data.strings!.cantBeEmpty}'
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget kota() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                  System.data.strings!.city,
                ),
              ],
            ),
            value: signupViewModel.kota,
            items: List.generate(signupViewModel.kotas.length, (index) {
              return DropdownMenuItem<KotaModel>(
                  value: signupViewModel.kotas[index],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(signupViewModel.kotas[index].name ?? ""),
                    ],
                  ));
            }),
            onChanged: (kota) {
              signupViewModel.kota = kota;
            },
          )
        ],
      ),
    );
  }

  Widget noTelp() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: signupViewModel.telpTextEditingController,
            decoration: InputDecoration(
              labelText: System.data.strings!.phoneNumber,
              errorText: signupViewModel.telp
                  ? '${System.data.strings!.phoneNumber} ${System.data.strings!.cantBeEmpty}'
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget kataSandi() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: signupViewModel.kataSandiTextEditingController,
            decoration: InputDecoration(
              labelText: System.data.strings!.password,
              errorText: signupViewModel.kataSandi
                  ? '${System.data.strings!.password} ${System.data.strings!.cantBeEmpty}'
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget namaPengguna() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: signupViewModel.namaPenggunaTextEditingController,
            decoration: InputDecoration(
              labelText: System.data.strings!.username,
              errorText: signupViewModel.namaPengguna
                  ? '${System.data.strings!.username} ${System.data.strings!.cantBeEmpty}'
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
