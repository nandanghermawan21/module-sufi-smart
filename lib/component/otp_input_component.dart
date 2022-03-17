import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sufismart/util/system.dart';

class InputOtpComponent extends StatelessWidget {
  final InputOtpController controller;
  final bool cover;

  const InputOtpComponent({
    Key? key,
    required this.controller,
    this.cover = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<InputOtpValue>(
        valueListenable: controller,
        builder: (ctx, value, widget) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: null,
            child: Stack(
              children: [
                Container(
                  color: (cover && value.state != InputOtpState.idle) == false
                      ? null
                      : Colors.grey.shade400.withOpacity(0.4),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  child: childBuilder(value.state),
                )
              ],
            ),
          );
        });
  }

  Widget childBuilder(InputOtpState state) {
    switch (state) {
      case InputOtpState.idle:
        return otpView();
      case InputOtpState.onLoad:
        return otpView();
    }
  }

  Widget otpView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 10),
          child: const Text(
            "Enter OTP",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: const Text(
            "enter the otp code that has been sent to no 085715532031",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
        rowOTP(),
        Container(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: const Text(
            "Not Receive OTP ? Resend",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: const Text("1"),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: const Text("2"),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: const Text("3"),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: const Text("4"),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: const Text("5"),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: const Text("6"),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: const Text("7"),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: const Text("8"),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: const Text("9"),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: const Text("Clear"),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: const Text("0"),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: const Text("Delete"),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget rowOTP() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: SizedBox(
            height: 30,
            child: TextField(
              keyboardType: TextInputType.number,
              //autofocus: false,
              maxLength: 1,
              textAlign: TextAlign.center,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("[0-9]")),
              ],
              decoration: const InputDecoration(
                  counterText: '',
                  fillColor: Colors.white,
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffcccccc)))),
              style: const TextStyle(
                backgroundColor: Colors.white,
                fontSize: 40,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: SizedBox(
            height: 30,
            child: TextField(
              keyboardType: TextInputType.number,
              //autofocus: false,
              maxLength: 1,
              textAlign: TextAlign.center,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("[0-9]")),
              ],
              decoration: const InputDecoration(
                  counterText: '',
                  fillColor: Colors.white,
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffcccccc)))),
              style: const TextStyle(
                backgroundColor: Colors.white,
                fontSize: 40,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: SizedBox(
            height: 30,
            child: TextField(
              keyboardType: TextInputType.number,
              //autofocus: false,
              maxLength: 1,
              textAlign: TextAlign.center,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("[0-9]")),
              ],
              decoration: const InputDecoration(
                  counterText: '',
                  fillColor: Colors.white,
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffcccccc)))),
              style: const TextStyle(
                backgroundColor: Colors.white,
                fontSize: 40,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: SizedBox(
            height: 30,
            child: TextField(
              keyboardType: TextInputType.number,
              //autofocus: false,
              maxLength: 1,
              textAlign: TextAlign.center,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("[0-9]")),
              ],
              decoration: const InputDecoration(
                  counterText: '',
                  fillColor: Colors.white,
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffcccccc)))),
              style: const TextStyle(
                backgroundColor: Colors.white,
                fontSize: 40,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: SizedBox(
            height: 30,
            child: TextField(
              keyboardType: TextInputType.number,
              //autofocus: false,
              maxLength: 1,
              textAlign: TextAlign.center,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("[0-9]")),
              ],
              decoration: const InputDecoration(
                  counterText: '',
                  fillColor: Colors.white,
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffcccccc)))),
              style: const TextStyle(
                backgroundColor: Colors.white,
                fontSize: 40,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: SizedBox(
            height: 30,
            child: TextField(
              keyboardType: TextInputType.number,
              //autofocus: false,
              maxLength: 1,
              textAlign: TextAlign.center,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("[0-9]")),
              ],
              decoration: const InputDecoration(
                  counterText: '',
                  fillColor: Colors.white,
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffcccccc)))),
              style: const TextStyle(
                backgroundColor: Colors.white,
                fontSize: 40,
              ),
            ),
          ),
        ),
      ],
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
        child: const Text("Send"),
      ),
    );
  }
}

class InputOtpController extends ValueNotifier<InputOtpValue> {
  InputOtpController({InputOtpValue? value}) : super(value ?? InputOtpValue());

  void open() {
    value.state = InputOtpState.onLoad;
    commit();
  }

  void close() {
    if (value.state == InputOtpState.onLoad) return;
    value.state = InputOtpState.idle;
    commit();
  }

  void commit() {
    notifyListeners();
  }
}

class InputOtpValue {
  InputOtpState state = InputOtpState.idle;
}

enum InputOtpState { idle, onLoad }
