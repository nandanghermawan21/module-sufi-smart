import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sufismart/component/cilcular_loader_component.dart';
import 'package:sufismart/component/pin_component.dart';
import 'package:sufismart/model/customernew_model.dart';
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/view_model/login_view_model.dart';

class LoginView extends StatefulWidget {
  final VoidCallback? gotoSignup;
  final VoidCallback? gotoForgetPassword;
  final ValueChanged<CustomerNewModel>? onLoginSuccess2;

  const LoginView({
    Key? key,
    this.gotoSignup,
    this.onLoginSuccess2,
    this.gotoForgetPassword,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<LoginView> {
  LoginViewModel loginViewModel = LoginViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: loginViewModel,
      child: CircularLoaderComponent(
        controller: loginViewModel.circularLoaderController,
        child: Stack(
          children: [
            Scaffold(
              resizeToAvoidBottomInset: false,
              body: SingleChildScrollView(
                child: Consumer<LoginViewModel>(
                  builder: (c, d, w) {
                    return Container(
                      margin: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Container(
                            color: Colors.transparent,
                            margin: const EdgeInsets.only(top: 5),
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              System.data.strings!.welcomeBack,
                              style: TextStyle(
                                  color: System.data.color!.primaryColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              System.data.strings!
                                  .enterYourEmailAndPasswordRegisteredInTheSUFISMARTApplication,
                              style: TextStyle(
                                color: System.data.color!.primaryColor,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Form(
                            key: loginViewModel.formKeyContact,
                            autovalidateMode: AutovalidateMode.always,
                            child: Container(
                              color: Colors.transparent,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  const SizedBox(height: 10),
                                  email(),
                                  const SizedBox(height: 20),
                                  password(),
                                  const SizedBox(height: 10),

                                  // TextField(
                                  //   controller:
                                  //       loginViewModel.emailTextEditingController,
                                  //   keyboardType: TextInputType.emailAddress,
                                  //   decoration: InputDecoration(
                                  //     labelText:
                                  //         '${System.data.strings!.enterThe} ${System.data.strings!.email}',
                                  //     errorText: loginViewModel.emailValidation
                                  //         ? '${System.data.strings!.email} ${System.data.strings!.cantBeEmpty}'
                                  //         : null,
                                  //   ),
                                  // ),
                                  // TextField(
                                  //   controller:
                                  //       loginViewModel.passwordTextEditingController,
                                  //   obscureText: loginViewModel.showPassword,
                                  //   decoration: InputDecoration(
                                  //     labelText:
                                  //         '${System.data.strings!.enterThe} ${System.data.strings!.password}',
                                  //     errorText: loginViewModel.passwordValidation
                                  //         ? '${System.data.strings!.password} ${System.data.strings!.cantBeEmpty}'
                                  //         : null,
                                  //     suffixIcon: IconButton(
                                  //       onPressed: () {
                                  //         loginViewModel.setShowPassword =
                                  //             !loginViewModel.showPassword;
                                  //       },
                                  //       icon: Icon(
                                  //         loginViewModel.showPassword
                                  //             ? FontAwesomeIcons.eyeSlash
                                  //             : FontAwesomeIcons.eye,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  GestureDetector(
                                    onTap: () {
                                      widget.gotoForgetPassword!();
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 15),
                                      color: Colors.transparent,
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            System.data.strings!.forgotPassword,
                                            style: TextStyle(
                                                color: System
                                                    .data.color!.primaryColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.right,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      if (loginViewModel
                                          .formKeyContact.currentState!
                                          .validate()) {
                                        ModeUtil.debugPrint("masuk");
                                        loginViewModel.login2(
                                          onLoginSuccess2:
                                              widget.onLoginSuccess2,
                                        );
                                      }
                                    },
                                    child: Container(
                                      height: 50,
                                      width: double.infinity,
                                      margin: const EdgeInsets.only(
                                          bottom: 10, top: 15),
                                      decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Color(0xff0d306b),
                                              Colors.indigo,
                                            ],
                                          ),
                                          color:
                                              System.data.color!.primaryColor,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5))),
                                      child: Center(
                                        child: Text(
                                          System.data.strings!.login,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      widget.gotoSignup!();
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          bottom: 5, top: 10),
                                      width: double.infinity,
                                      // decoration: BoxDecoration(
                                      //     color: System.data.color!.greyColor,
                                      //     borderRadius: const BorderRadius.all(
                                      //         Radius.circular(5))),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              System
                                                  .data.strings!.doesNotHaveAcc,
                                              style: TextStyle(
                                                color: System
                                                    .data.color!.greyColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                            Text(
                                              System.data.strings!.signUp,
                                              style: TextStyle(
                                                color: System
                                                    .data.color!.primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget pin() {
    return PinComponent(
      controller: loginViewModel.pinComponentController,
    );
  }

  Widget email() {
    return TextFormField(
      controller: loginViewModel.emailTextEditingController,
      autofocus: false,
      decoration: InputDecoration(
        labelText: System.data.strings!.email,
        labelStyle: const TextStyle(
          color: Colors.grey,
        ),
        // focusedBorder: const OutlineInputBorder(
        //   borderSide: BorderSide(color: Colors.grey),
        // ),
        // enabledBorder: OutlineInputBorder(
        //   borderSide: BorderSide(color: System.data.color!.primaryColor),
        //   borderRadius: BorderRadius.circular(15),
        // ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: System.data.color!.primaryColor),
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        suffixIcon: const Icon(Icons.mail),
      ),
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
        loginViewModel.email = value!;
      },
    );
  }

  Widget password() {
    return TextFormField(
      controller: loginViewModel.passwordTextEditingController,
      autofocus: false,
      obscureText: loginViewModel.showPassword,
      decoration: InputDecoration(
        labelText: System.data.strings!.password,
        labelStyle: const TextStyle(
          color: Colors.grey,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: System.data.color!.primaryColor),
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            loginViewModel.setShowPassword = !loginViewModel.showPassword;
          },
          icon: Icon(
            loginViewModel.showPassword
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
}
