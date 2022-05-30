import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sufismart/component/circular_loader_component.dart';
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/view_model/forgot_password_view_model.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  State<StatefulWidget> createState() {
    return _ForgotPasswordViewState();
  }
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  ForgotPasswordViewModel forgotPasswordViewModel = ForgotPasswordViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: forgotPasswordViewModel,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: appBar(),
        body: CircularLoaderComponent(
          controller: forgotPasswordViewModel.circularLoaderController,
          child: SingleChildScrollView(
            child: Consumer<ForgotPasswordViewModel>(
              builder: (c, d, w) {
                return Container(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          System.data.strings!.forgotPassword,
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
                          System.data.strings!.fillForgotPassword,
                          style: TextStyle(
                            color: System.data.color!.primaryColor,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Form(
                        key: forgotPasswordViewModel.formKeyContact,
                        autovalidateMode: AutovalidateMode.always,
                        child: Container(
                          margin: const EdgeInsets.only(top: 20),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              TextFormField(
                                controller:
                                    forgotPasswordViewModel.emailTextController,
                                autofocus: false,
                                decoration: InputDecoration(
                                    labelText: System.data.strings!.email,
                                    labelStyle: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey))),
                                keyboardType: TextInputType.emailAddress,
                                cursorColor: Colors.grey,
                                validator: (String? value) {
                                  RegExp regex = RegExp(
                                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                                  if (value!.isEmpty) {
                                    return (System.data.strings!.email) +
                                        (" " +
                                            System.data.strings!.canNotBeEmpty);
                                  } else if (!regex.hasMatch(value)) {
                                    return System
                                        .data.strings!.enterAValidEmail;
                                  }
                                  return null;
                                },
                                onSaved: (String? value) {
                                  forgotPasswordViewModel.setEmail = value!;
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (forgotPasswordViewModel
                                      .formKeyContact.currentState!
                                      .validate()) {
                                    ModeUtil.debugPrint(
                                        "homeViewModel.formKeyContact.currentState ${forgotPasswordViewModel.formKeyContact.currentState}");

                                    ModeUtil.debugPrint("masuk");
                                    forgotPasswordViewModel
                                        .sendForgotPassword();
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
                                      System.data.strings!.send,
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
