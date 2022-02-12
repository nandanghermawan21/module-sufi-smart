import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/view_model/login_view_model.dart';
import 'package:sufismart/component/basic_component.dart';
import 'package:sufismart/view_model/main_menu_view_model.dart';

class LoginView extends StatefulWidget {
  final VoidCallback? gotoSignup;
  final VoidCallback? gotoMain;

  const LoginView({
    Key? key,
    this.gotoSignup,
    this.gotoMain,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<LoginView> {
  LoginViewModel loginViewModel = LoginViewModel();
  MainMenuViewModel mainMenuViewModel = MainMenuViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: loginViewModel,
      child: Scaffold(
        appBar: BasicComponent.appBar(actions: [BasicComponent.dropDownLang()]),
        body: SingleChildScrollView(
          child: Consumer<LoginViewModel>(
            builder: (c, d, w) {
              return Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        System.data.strings!.welcomeBack,
                        style: TextStyle(
                            color: System.data.color!.primaryColor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
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
                        textAlign: TextAlign.left,
                      ),
                    ),
                    TextField(
                      controller: loginViewModel.emailTextEditingController,
                      decoration: InputDecoration(
                        labelText:
                            '${System.data.strings!.enterThe} ${System.data.strings!.email}',
                        errorText: loginViewModel.emailValidation
                            ? '${System.data.strings!.email} ${System.data.strings!.cantBeEmpty}'
                            : null,
                      ),
                    ),
                    TextField(
                      controller: loginViewModel.passwordTextEditingController,
                      obscureText: loginViewModel.showPassword,
                      decoration: InputDecoration(
                        labelText:
                            '${System.data.strings!.enterThe} ${System.data.strings!.password}',
                        errorText: loginViewModel.passwordValidation
                            ? '${System.data.strings!.password} ${System.data.strings!.cantBeEmpty}'
                            : null,
                        suffixIcon: IconButton(
                          onPressed: () {
                            loginViewModel.setShowPassword =
                                !loginViewModel.showPassword;
                          },
                          icon: Icon(
                            loginViewModel.showPassword
                                ? FontAwesomeIcons.eye
                                : FontAwesomeIcons.eyeSlash,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        loginViewModel.login();
                        if (loginViewModel.emailValidation == false &&
                            loginViewModel.passwordValidation == false) {
                          widget.gotoMain!();
                        }
                      },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 10, top: 30),
                        decoration: BoxDecoration(
                            color: System.data.color!.primaryColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
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
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
