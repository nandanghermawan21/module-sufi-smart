import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sufismart/component/circular_loader_component.dart';
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/view_model/change_pass_view_model.dart';

import '../component/basic_component.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  State<StatefulWidget> createState() {
    return _ChangePasswordViewState();
  }
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  ChangePassViewModel changePassViewModel = ChangePassViewModel();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: changePassViewModel,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: BasicComponent.appBar(),
        body: CircularLoaderComponent(
          controller: changePassViewModel.circularLoaderController,
          child: SingleChildScrollView(
            child: Consumer<ChangePassViewModel>(
              builder: (c, d, w) {
                return Container(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          System.data.strings!.settingPassword,
                          style: TextStyle(
                              color: System.data.color!.primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const Divider(),
                      Form(
                        key: changePassViewModel.formKeyContact,
                        autovalidateMode: AutovalidateMode.always,
                        child: Container(
                          margin: const EdgeInsets.only(top: 5),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              TextFormField(
                                controller:
                                    changePassViewModel.passwordlamaController,
                                autofocus: false,
                                obscureText:
                                    changePassViewModel.showPasswordLama,
                                decoration: InputDecoration(
                                  labelText: System.data.strings!.passwordLama,
                                  labelStyle: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      changePassViewModel.setShowPasswordLama =
                                          !changePassViewModel.showPasswordLama;
                                    },
                                    icon: Icon(
                                      changePassViewModel.showPasswordLama
                                          ? FontAwesomeIcons.eyeSlash
                                          : FontAwesomeIcons.eye,
                                    ),
                                  ),
                                ),
                                cursorColor: Colors.grey,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return '${System.data.strings!.passwordLama} ${System.data.strings!.cantBeEmpty}';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              TextFormField(
                                controller:
                                    changePassViewModel.passwordbaruController,
                                autofocus: false,
                                obscureText:
                                    changePassViewModel.showPasswordBaru,
                                decoration: InputDecoration(
                                  labelText: System.data.strings!.passwordBaru,
                                  labelStyle: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      changePassViewModel.setShowPasswordbaru =
                                          !changePassViewModel.showPasswordBaru;
                                    },
                                    icon: Icon(
                                      changePassViewModel.showPasswordBaru
                                          ? FontAwesomeIcons.eyeSlash
                                          : FontAwesomeIcons.eye,
                                    ),
                                  ),
                                ),
                                cursorColor: Colors.grey,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return '${System.data.strings!.passwordBaru} ${System.data.strings!.cantBeEmpty}';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              TextFormField(
                                controller: changePassViewModel
                                    .passwordconfirmController,
                                autofocus: false,
                                obscureText:
                                    changePassViewModel.showPasswordConfirm,
                                decoration: InputDecoration(
                                  labelText:
                                      System.data.strings!.passwordConfirm,
                                  labelStyle: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      changePassViewModel
                                              .setShowPasswordConfirm =
                                          !changePassViewModel
                                              .showPasswordConfirm;
                                    },
                                    icon: Icon(
                                      changePassViewModel.showPasswordConfirm
                                          ? FontAwesomeIcons.eyeSlash
                                          : FontAwesomeIcons.eye,
                                    ),
                                  ),
                                ),
                                cursorColor: Colors.grey,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return '${System.data.strings!.passwordConfirm} ${System.data.strings!.cantBeEmpty}';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (changePassViewModel
                                      .formKeyContact.currentState!
                                      .validate()) {
                                    ModeUtil.debugPrint(
                                        "homeViewModel.formKeyContact.currentState ${changePassViewModel.formKeyContact.currentState}");

                                    ModeUtil.debugPrint("masuk");
                                    changePassViewModel.sendChangePassword();
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: System.data.color!.primaryColor,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5))),
                                  child: Center(
                                    child: Text(
                                      System.data.strings!.update,
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
}
