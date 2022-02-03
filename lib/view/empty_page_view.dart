import 'package:flutter/material.dart';
import 'package:sufismart/util/system.dart';

class EmptyPageView extends StatefulWidget {
  const EmptyPageView({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _EmptyPageViewState();
  }
}

class _EmptyPageViewState extends State<EmptyPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          System.data.strings!.underConstruction,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
