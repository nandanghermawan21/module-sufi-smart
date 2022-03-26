import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CircularLoaderComponent extends StatelessWidget {
 final CircularLoaderController controller;
  final bool cover;
  final Widget? child;
  final Widget? onLoadingWidget;

  const CircularLoaderComponent({
    Key? key,
    required this.controller,
    this.cover = true,
    this.child,
    this.onLoadingWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<CircularLoaderValue>(
      valueListenable: controller,
      builder: (ctx, value, widget) {
        return GestureDetector(
          onTap: () {
            controller.close();
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.transparent,
            child: Stack(
              children: [
                child ?? const SizedBox(),
                Container(
                  color: (cover && value.state != CircularLoaderState.idle) ==
                          false
                      ? null
                      : Colors.grey.shade400.withOpacity(0.6),
                  child: childBuilder(value.state),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget childBuilder(CircularLoaderState state) {
    switch (state) {
      case CircularLoaderState.idle:
        return const SizedBox();
      case CircularLoaderState.onLoading:
        return onLoadingWidget != null ? onLoadingWidget! : onLoading();
      case CircularLoaderState.showError:
        return messageError();
      case CircularLoaderState.showMessage:
        return message();
    }
  }

  Widget onLoading() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.only(left: 40, right: 40),
        height: 50,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 50,
              width: 50,
              padding: const EdgeInsets.all(10),
              color: Colors.transparent,
              child: const CircularProgressIndicator(
                color: Colors.blue,
                strokeWidth: 2,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const Expanded(
                child: Text(
              "Loading",
            ))
          ],
        ),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              FontAwesomeIcons.checkCircle,
              color: Colors.green,
              size: 50,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              controller.value.message ?? "Success",
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              FontAwesomeIcons.timesCircle,
              color: Colors.red,
              size: 50,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              controller.value.message ?? "Error",
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}

class CircularLoaderController extends ValueNotifier<CircularLoaderValue> {
  CircularLoaderController({CircularLoaderValue? value})
      : super(value ?? CircularLoaderValue());

  void startLoading() {
    value.state = CircularLoaderState.onLoading;
    commit();
  }

  void stopLoading({
    String? message,
    bool isError = false,
    Duration? duration,
    VoidCallback? onCloseCallBack,
  }) {
    value.state = isError == true
        ? CircularLoaderState.showError
        : CircularLoaderState.showMessage;

    if (duration != null) {
      Timer.periodic(duration, (timer) {
        timer.cancel();
        close();
      });
    }

    if (message != null) {
      value.message = message;
    }

    if (onCloseCallBack != null) {
      onCloseCallBack();
    }

    commit();
  }

  void forceStop() {
    value.state = CircularLoaderState.idle;
    commit();
  }

  void close() {
    if (value.state == CircularLoaderState.onLoading) return;
    value.state = CircularLoaderState.idle;
    commit();
  }

  void commit() {
    notifyListeners();
  }

  void forceClose() {}
}

class CircularLoaderValue {
  CircularLoaderState state = CircularLoaderState.idle;
  String? message;
}

enum CircularLoaderState {
  idle,
  onLoading,
  showError,
  showMessage,
}
