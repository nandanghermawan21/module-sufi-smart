import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OtpComponent extends StatelessWidget {
  final OTPController controller;
  final bool cover;
  final Widget? child;

  const OtpComponent({
    Key? key,
    required this.controller,
    this.cover = true,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller1 = new TextEditingController();
    TextEditingController controller2 = new TextEditingController();
    TextEditingController controller3 = new TextEditingController();
    TextEditingController controller4 = new TextEditingController();
    TextEditingController controller5 = new TextEditingController();
    TextEditingController controller6 = new TextEditingController();

    TextEditingController currController = new TextEditingController();

    return ValueListenableBuilder<CircularLoaderValue>(
      valueListenable: controller,
      builder: (ctx, value, widget) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          color: null,
          child: Stack(
            children: [
              child ?? const SizedBox(),
              GestureDetector(
                onTap: controller.close,
                child: Container(
                  color: (cover && value.state != OTPState.idle) == false
                      ? null
                      : Colors.grey.shade400.withOpacity(0.4),
                  child: childBuilder(
                    value.state,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget childBuilder(OTPState state) {
    switch (state) {
      case OTPState.idle:
        return const SizedBox();
      case OTPState.onLoading:
        return onLoading();
      case OTPState.showError:
        return messageError();
      case OTPState.showMessage:
        return message();
    }
  }

  Widget onLoading() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        // margin: const EdgeInsets.only(left: 40, right: 40),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: Border.all(
            color: Colors.grey,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 5,
              offset: const Offset(2, 2),
            )
          ],
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text("Enter OTP"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                      "Enter OTP code that has been sent to your number"),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  color: Colors.grey[400],
                  alignment: Alignment.centerLeft,
                  child: otp1(""),
                ),
                Container(
                  width: 50,
                  height: 50,
                  color: Colors.grey[400],
                  alignment: Alignment.centerLeft,
                  child: otp2(""),
                ),
                Container(
                  width: 50,
                  height: 50,
                  color: Colors.grey[400],
                  alignment: Alignment.centerLeft,
                  child: otp3(""),
                ),
                Container(
                  width: 50,
                  height: 50,
                  color: Colors.grey[400],
                  alignment: Alignment.centerLeft,
                  child: otp4(""),
                ),
                Container(
                  width: 50,
                  height: 50,
                  color: Colors.grey[400],
                  alignment: Alignment.centerLeft,
                  child: otp5(""),
                ),
                Container(
                  width: 50,
                  height: 50,
                  color: Colors.grey[400],
                  alignment: Alignment.centerLeft,
                  child: otp6(""),
                ),
              ],
            ),
            const SizedBox(height: 50),
            const Divider(color: Colors.black),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    input("1", Nourut.A);
                  },
                  child: Container(
                    width: 100,
                    height: 50,
                    alignment: Alignment.center,
                    child: const Text("1"),
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      input("2", Nourut.B);
                    },
                    child: Container(
                      width: 100,
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text("2"),
                    )),
                GestureDetector(
                    onTap: () {
                      input("3", Nourut.C);
                    },
                    child: Container(
                      width: 100,
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text("3"),
                    )),
              ],
            ),
            const Divider(color: Colors.black),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      input("4", Nourut.D);
                    },
                    child: Container(
                      width: 100,
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text("4"),
                    )),
                GestureDetector(
                    onTap: () {
                      input("5", Nourut.E);
                    },
                    child: Container(
                      width: 100,
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text("5"),
                    )),
                GestureDetector(
                    onTap: () {
                      input("6", Nourut.F);
                    },
                    child: Container(
                      width: 100,
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text("6"),
                    )),
              ],
            ),
            const Divider(color: Colors.black),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      input("7", Nourut.A);
                    },
                    child: Container(
                      width: 100,
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(controller.value.loadingMessage ?? "7"),
                    )),
                GestureDetector(
                    onTap: () {
                      input("8", Nourut.B);
                    },
                    child: Container(
                      width: 100,
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text("8"),
                    )),
                GestureDetector(
                    onTap: () {
                      input("9", Nourut.F);
                    },
                    child: Container(
                      width: 100,
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text("9"),
                    )),
              ],
            ),
            const Divider(color: Colors.black),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 100,
                  height: 50,
                  alignment: Alignment.center,
                  child: const Text("Clear"),
                ),
                GestureDetector(
                    onTap: () {
                      input("0", Nourut.A);
                    },
                    child: Container(
                      width: 100,
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text("0"),
                    )),
                Container(
                  width: 100,
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(controller.value.loadingMessage ?? "Delete"),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(bottom: 5),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Center(
                  child: Text(
                    "SEND",
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
    );
  }

  void input(String angka, Nourut state) {
    if (state == Nourut.A) {
      otp1(angka);
    } else if (state == Nourut.B) {
      otp2(angka);
    } else if (state == Nourut.C) {
      otp3(angka);
    } else if (state == Nourut.D) {
      otp4(angka);
    } else if (state == Nourut.E) {
      otp5(angka);
    } else if (state == Nourut.F) {
      otp6(angka);
    } else {
      otp1(angka);
    }

    print("Hasil");
    print(Nourut);
    print(angka);
  }

  Widget otp1(String angka) {
    return Container(
      child: Text(
        angka,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget otp2(String angka) {
    return Container(
      child: Text(
        angka,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget otp3(String angka) {
    return Container(
      child: Text(
        angka,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget otp4(String angka) {
    return Container(
      child: Text(
        angka,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget otp5(String angka) {
    return Container(
      child: Text(
        angka,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget otp6(String angka) {
    return Container(
      child: Text(
        angka,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget message() {
    return Align(
        alignment: Alignment.center,
        child: Container(
          margin: const EdgeInsets.only(left: 40, right: 40),
          padding: const EdgeInsets.all(15),
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            border: Border.all(
              color: Colors.grey,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 5,
                offset: const Offset(2, 2),
              )
            ],
          ),
          child: Column(
            children: [
              const Icon(
                FontAwesomeIcons.checkCircle,
                color: Colors.green,
                size: 50,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                controller.value.message ?? "",
                textAlign: TextAlign.center,
              )
            ],
          ),
        ));
  }

  Widget messageError() {
    return Align(
        alignment: Alignment.center,
        child: Container(
          margin: const EdgeInsets.only(left: 40, right: 40),
          padding: const EdgeInsets.all(15),
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            border: Border.all(
              color: Colors.grey,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 5,
                offset: const Offset(2, 2),
              )
            ],
          ),
          child: Column(
            children: [
              const Icon(
                FontAwesomeIcons.timesCircle,
                color: Colors.red,
                size: 50,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                controller.value.message ?? "",
                textAlign: TextAlign.center,
              )
            ],
          ),
        ));
  }
}

class OTPController extends ValueNotifier<CircularLoaderValue> {
  OTPController({CircularLoaderValue? value})
      : super(value ?? CircularLoaderValue());

  void startLoading() {
    value.state = OTPState.onLoading;
    commit();
  }

  void stopLoading({
    String? message,
    bool isError = false,
    Duration? duration,
    VoidCallback? onCloseCallBack,
  }) {
    value.state = isError == true ? OTPState.showError : OTPState.showMessage;
    value.message = message;

    if (duration != null) {
      Timer.periodic(duration, (timer) {
        timer.cancel();
        close();
      });
    }

    if (onCloseCallBack != null) {
      onCloseCallBack();
    }

    commit();
  }

  void close() {
    if (value.state == OTPState.onLoading) return;
    value.state = OTPState.idle;
    commit();
  }

  void commit() {
    notifyListeners();
  }
}

class CircularLoaderValue {
  OTPState state = OTPState.idle;
  String? loadingMessage;
  String? message;
}

enum OTPState {
  idle,
  onLoading,
  showError,
  showMessage,
}

enum Nourut { A, B, C, D, E, F }
