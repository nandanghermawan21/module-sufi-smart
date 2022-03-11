import 'package:flutter/material.dart';
import 'package:sufismart/util/system.dart';

class Akunview extends StatefulWidget {
  const Akunview({Key? key}) : super(key: key);

  @override
  _AkunviewState createState() => _AkunviewState();
}

class _AkunviewState extends State<Akunview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 50),
                child: Image.asset(
                  'assets/logo_suzuki.png',
                  height: 100.0,
                  width: 100.0,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(top: 20),
                child: Column(
                  children: <Widget>[
                    Text(
                      System.data.strings!.appName,
                      style: TextStyle(
                        color: System.data.color!.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      System.data.strings!.version,
                      style: TextStyle(
                        color: System.data.color!.primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 50),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            System.data.strings!.callCenter,
                            style: TextStyle(
                              color: System.data.color!.primaryColor,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            System.data.strings!.numberCallCenter,
                            style: TextStyle(
                              color: System.data.color!.primaryColor,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            System.data.strings!.email,
                            style: TextStyle(
                              color: System.data.color!.primaryColor,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            System.data.strings!.emailCS,
                            style: TextStyle(
                              color: System.data.color!.primaryColor,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
