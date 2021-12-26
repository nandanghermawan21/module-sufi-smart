import 'package:flutter/material.dart';
import 'package:sufismart/ui/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sufi Smart',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (BuildContext context) => const HomeView(),
      },
      initialRoute: "/",
    );
  }
} 
