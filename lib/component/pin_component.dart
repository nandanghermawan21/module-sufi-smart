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
                          ),
                          keyPad(
                            label: "0",
                          ),
                          keyPad(
                            label: "Delete",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget keyPad({
  String? label,
  VoidCallback? onTap,
}) {
  return Expanded(
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
          "$label",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
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
