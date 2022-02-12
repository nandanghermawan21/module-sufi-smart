import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sufismart/model/kota_model.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/view_model/signup_view_model.dart';
import 'package:sufismart/component/basic_component.dart';
import 'package:sufismart/view_model/main_menu_view_model.dart';
import 'package:sufismart/model/jenis_kelamin_model.dart';

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  SignupViewModel signupviewmodel = SignupViewModel();
  MainMenuViewModel mainMenuViewModel = MainMenuViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: signupviewmodel,
      child: Scaffold(
        appBar: BasicComponent.appBar(actions: [
          BasicComponent.dropDownLang(),
        ]),
        body: SingleChildScrollView(
          child: Consumer<SignupViewModel>(
            builder: (c, d, w) {
              return Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    judul(),
                    subJudul(),
                    const SizedBox(
                      height: 40,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            photo(),
                            Column(children: [ktp(), jeniskelamin()])
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    namaLengkap(),
                    const SizedBox(
                      height: 20,
                    ),
                    kota(),
                    const SizedBox(
                      height: 20,
                    ),
                    nomorponsel(),
                    const SizedBox(
                      height: 20,
                    ),
                    namapengguna(),
                    const SizedBox(
                      height: 20,
                    ),
                    katasandi(),
                    const SizedBox(
                      height: 20,
                    ),
                    tombol(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget judul() {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      width: MediaQuery.of(context).size.width,
      child: Text(
        System.data.strings!.judulSignup,
        style: TextStyle(
            color: System.data.color!.primaryColor,
            fontSize: 22,
            fontWeight: FontWeight.bold),
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget subJudul() {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      width: MediaQuery.of(context).size.width,
      child: Text(
        System.data.strings!.subJudulSignup,
        style: TextStyle(
            color: System.data.color!.primaryColor,
            fontSize: 16,
            fontWeight: FontWeight.bold),
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget photo() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          border: Border.all(color: Colors.black, width: 2)),
      width: 110,
      height: 120,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(Icons.camera_alt_outlined, size: 70)]),
    );
  }

  Widget ktp() {
    return Container(
      width: 200,
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            System.data.strings!.ktp,
          ),
          const SizedBox(
            height: 0,
          ),
          TextField(
            controller: signupviewmodel.kTPTextEditingController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: System.data.strings!.ktp,
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
            height: 0,
          ),
        ],
      ),
    );
  }

  Widget jeniskelamin() {
    return Container(
      width: 200,
      height: 80,
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children:
            List.generate(signupviewmodel.listJenisKelamin.length, (index) {
          return Expanded(
            child: Row(
              children: [
                Radio<JenisKelaminModel>(
                  value: signupviewmodel.listJenisKelamin[index],
                  onChanged: (val) {
                    signupviewmodel.jenisKelamin =
                        signupviewmodel.listJenisKelamin[index];
                  },
                  activeColor: System.data.color!.primaryColor,
                  groupValue: signupviewmodel.jenisKelamin,
                ),
                Expanded(
                  child: Container(
                      width: double.infinity,
                      height: 15,
                      color: Colors.transparent,
                      child: FittedBox(
                        child: Text(
                            signupviewmodel.listJenisKelamin[index].name ?? ""),
                      )),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget namaLengkap() {
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            System.data.strings!.namalengkap,
          ),
          const SizedBox(
            height: 0,
          ),
          TextField(
            controller: signupviewmodel.namalengkapTextEditingController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: System.data.strings!.namalengkap,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: System.data.color!.primaryColor, width: 1.0),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: System.data.color!.primaryColor, width: 1.0),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget kota() {
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            System.data.strings!.kota,
          ),
          const SizedBox(
            height: 10,
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
                  System.data.strings!.kota,
                ),
              ],
            ),
            value: signupviewmodel.getKota,
            items: List.generate(signupviewmodel.listKota.length, (index) {
              return DropdownMenuItem<KotaModel>(
                  value: signupviewmodel.listKota[index],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(signupviewmodel.listKota[index].name ?? ""),
                    ],
                  ));
            }),
            onChanged: (val) {
              signupviewmodel.setKota = val;
            },
          )
        ],
      ),
    );
  }

  Widget nomorponsel() {
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            System.data.strings!.nomorponsel,
          ),
          const SizedBox(
            height: 0,
          ),
          TextField(
            controller: signupviewmodel.nohpTextEditingController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: System.data.strings!.nomorponsel,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: System.data.color!.primaryColor, width: 1.0),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: System.data.color!.primaryColor, width: 1.0),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget namapengguna() {
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            System.data.strings!.namapengguna,
          ),
          const SizedBox(
            height: 0,
          ),
          TextField(
            controller: signupviewmodel.namapenggunaTextEditingController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: System.data.strings!.namapengguna,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: System.data.color!.primaryColor, width: 1.0),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: System.data.color!.primaryColor, width: 1.0),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget katasandi() {
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            System.data.strings!.katasandi,
          ),
          const SizedBox(
            height: 0,
          ),
          TextField(
            controller: signupviewmodel.katasandiTextEditingController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: System.data.strings!.katasandi,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: System.data.color!.primaryColor, width: 1.0),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: System.data.color!.primaryColor, width: 1.0),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget tombol() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(bottom: 5),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            color: System.data.color!.primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Center(
          child: Text(
            System.data.strings!.signUp,
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
}
