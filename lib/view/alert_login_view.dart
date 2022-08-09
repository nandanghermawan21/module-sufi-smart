import 'package:flutter/material.dart';
import 'package:sufismart/component/basic_component.dart';
import 'package:sufismart/util/system.dart';

class AlertLoginView extends StatefulWidget {
  const AlertLoginView({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AlertLoginViewState();
  }
}

class _AlertLoginViewState extends State<AlertLoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicComponent.appBar(),
      backgroundColor: System.data.color!.background,
      body: pageNoLogin(),
    );
  }

  AppBar appBar() {
    return AppBar(
      centerTitle:false,
      backgroundColor: System.data.color!.mainColor,
      title: Image.asset(
        "assets/logo_sfi_white.png",
        fit: BoxFit.cover,
        height: 30,
      ),
    );
  }

  Widget pageNoLogin() {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset("assets/not_login.png", width: 300),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Anda belum login",
                style: TextStyle(
                    color: System.data.color?.mainColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Silahkan login terlebih dahulu",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.all(15),
                color: Colors.transparent,
                height: 50,
                // width: MediaQuery.of(context).size.width ,
                width: 150,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          System.data.color!.primaryColor)),
                  onPressed: () {
                    // signupViewModel.register(
                    //   onRegisterSuccess: widget.onRegisterSucces,
                    // );
                  },
                  child: Text(System.data.strings!.login),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
