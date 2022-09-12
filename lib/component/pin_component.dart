import 'package:flutter/material.dart';
import 'package:sufismart/component/circular_loader_component.dart';
import 'package:sufismart/component/timer_component.dart';
import 'package:sufismart/util/system.dart';

class PinComponent extends StatelessWidget {
  final String? title;
  final PinComponentController controller;
  final ValueChanged<String>? onTapSend;
  final ValueChanged<String>? onTapResend;
  final ValueChanged<String>? checkTimer;

  const PinComponent(
      {Key? key,
      required this.controller,
      this.onTapSend,
      this.onTapResend,
      this.title,
      this.checkTimer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<PinComponentValue>(
      valueListenable: controller,
      builder: (ctxx, value, widget) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: CircularLoaderComponent(
            controller: value.loadingController,
            loadingBuilder: onLoading(),
            child: Center(
              child: Stack(
                children: [
                  pinPad(
                    context,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void open({
    required BuildContext context,
    required PinComponentController controller,
    String? title,
    Duration? timer,
    ValueChanged<String>? onTapSend,
    ValueChanged<String>? onTapResend,
  }) {
    controller.value.state = PinComponentState.opem;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return PinComponent(
          controller: controller,
          title: title,
          onTapResend: onTapResend,
          onTapSend: onTapSend,
        );
      },
    );
    if (timer != null) {
      controller.value.timerController.start(
        duration: timer,
      );
    }
    controller.commit();
  }

  Widget onLoading() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.only(left: 40, right: 40),
        height: 50,
        width: 50,
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
        child: Container(
          width: 50,
          height: 50,
          padding: const EdgeInsets.all(10),
          color: Colors.transparent,
          child: const CircularProgressIndicator(
            color: Colors.blue,
            strokeWidth: 2,
          ),
        ),
      ),
    );
  }

  Widget pinPad(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    titleWidget(),
                    const SizedBox(
                      height: 10,
                    ),
                    pinView(),
                    const SizedBox(
                      height: 10,
                    ),
                    timer(),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.transparent,
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          keyPad(
                            label: "1",
                          ),
                          keyPad(
                            label: "2",
                          ),
                          keyPad(
                            label: "3",
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          keyPad(
                            label: "4",
                          ),
                          keyPad(
                            label: "5",
                          ),
                          keyPad(
                            label: "6",
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          keyPad(
                            label: "7",
                          ),
                          keyPad(
                            label: "8",
                          ),
                          keyPad(
                            label: "9",
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          keyPad(
                            label: "Clear",
                            onTap: () {
                              controller.clear();
                            },
                          ),
                          keyPad(
                            label: "0",
                          ),
                          keyPad(
                              label: "Delete",
                              onTap: () {
                                controller.delete();
                              }),
                        ],
                      ),
                    ),
                    buttonSubmit(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget keyPad({
    required String label,
    VoidCallback? onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (onTap != null) {
            onTap();
          } else {
            controller.setPin(value: label);
          }
        },
        child: Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                offset: const Offset(1, 1),
              )
            ],
            border: Border.all(color: Colors.grey.shade400, width: 0.5),
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Widget titleWidget() {
    return Text(
      title ?? System.data.strings!.enterPin,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }

  Widget pinView() {
    return Container(
      color: Colors.transparent,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(6, (index) {
            return pinViewItem(
              index: index,
            );
          })),
    );
  }

  Widget pinViewItem({
    required int index,
  }) {
    return GestureDetector(
      onTap: () {
        controller.value.activePin = index;
        controller.commit();
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: index == controller.value.activePin
                  ? Colors.blue
                  : controller.value.invalidPins.contains(index)
                      ? Colors.red
                      : Colors.grey,
              width: 2,
            ),
          ),
        ),
        child: Center(
          child: Text(
            controller.value.pins[index] ?? "",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget timer() {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: TimerComponent(
          controller: controller.value.timerController,
          onFinish: (timer) {
            return timerFinish();
          },
        ),
      ),
    );
  }

  Widget timerFinish() {
    return GestureDetector(
      onTap: () {
        if (onTapResend != null) {
          onTapResend!(controller.readPin());
          controller.clear();
        }
      },
      child: Text(
        System.data.strings!.resend,
        style: const TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buttonSubmit() {
    return GestureDetector(
      onTap: () {
        if (controller.validatePin()) {
          if (onTapSend != null &&
              controller.value.timerController.value.secondLeft > 0) {
            onTapSend!(controller.readPin());
          }
        }
      },
      child: ValueListenableBuilder(
        valueListenable: controller.value.timerController,
        builder: (c, d, w) {
          return SafeArea(
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: controller.value.timerController.value.secondLeft > 0
                    ? System.data.color!.primaryColor
                    : Colors.grey,
              ),
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
          );
        },
      ),
    );
  }
}

class PinComponentController extends ValueNotifier<PinComponentValue> {
  PinComponentController({PinComponentValue? value})
      : super(value ?? PinComponentValue());

  void close() {
    value.state = PinComponentState.close;
    Navigator.of(System.data.context).pop();
    commit();
  }

  void setPin({
    required String value,
  }) {
    this.value.pins[this.value.activePin] = value;
    this.value.invalidPins.clear();
    nextPint();
    commit();
  }

  void nextPint() {
    if ((value.activePin + 1) < value.pinLength) {
      value.activePin = value.activePin + 1;
    }
    commit();
  }

  void clear() {
    value.activePin = 0;
    value.pins = {};
    value.invalidPins.clear();
    commit();
  }

  void delete() {
    value.pins[value.activePin] = " ";
    value.invalidPins.clear();
    prevPin();
    commit();
  }

  void prevPin() {
    if ((value.activePin - 1) >= 0) {
      value.activePin = value.activePin - 1;
    }
    commit();
  }

  String readPin() {
    String pin = "";
    for (var i = 0; i < value.pinLength; i++) {
      pin = pin + (value.pins[i] ?? " ");
    }
    return pin;
  }

  bool validatePin() {
    value.invalidPins = [];
    for (var i = 0; i < value.pinLength; i++) {
      if ((value.pins[i] ?? " ") == " ") {
        value.invalidPins.add(i);
      }
    }
    commit();
    if (value.invalidPins.isNotEmpty) {
      return false;
    } else {
      return true;
    }
  }

  void commit() {
    notifyListeners();
  }
}

class PinComponentValue {
  PinComponentState state = PinComponentState.close;
  CircularLoaderController loadingController = CircularLoaderController();
  TimerController timerController = TimerController();
  int pinLength = 6;
  int activePin = 0;
  Map<int, String> pins = {};
  List<int> invalidPins = [];
}

enum PinComponentState {
  opem,
  close,
  error,
}
