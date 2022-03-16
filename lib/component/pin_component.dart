import 'package:flutter/material.dart';

class PinComponent extends StatelessWidget {
  final PinComponentController controller;

  const PinComponent({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<PinComponentValue>(
      valueListenable: controller,
      builder: (ctxx, value, widget) {
        return Scaffold(
          backgroundColor: Colors.grey.withOpacity(0.5),
          body: Stack(
            children: [
              pinPad(context),
            ],
          ),
        );
      },
    );
  }

  Widget pinPad(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: MediaQuery.of(context).size.height < 300
            ? MediaQuery.of(context).size.height / 2
            : 300,
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
              flex: 1,
              child: Container(),
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.green,
                child: Column(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PinComponentController extends ValueNotifier<PinComponentValue> {
  PinComponentController({PinComponentValue? value})
      : super(value ?? PinComponentValue());
}

class PinComponentValue {
  PinComponentState state = PinComponentState.close;
}

enum PinComponentState {
  opem,
  close,
  error,
}
