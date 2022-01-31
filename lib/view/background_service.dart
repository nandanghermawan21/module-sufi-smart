import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BackgroundService extends StatefulWidget {
  const BackgroundService({
    Key? key,
  }) : super(key: key);

  @override
  BackgroundServiceState createState() => BackgroundServiceState();
}

class BackgroundServiceState extends State<BackgroundService> {
  static const platform = MethodChannel('samples.flutter.dev/battery');

  // Get battery level.
  String batteryLevel = 'Unknown battery level.';

  Future<void> getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      batteryLevel = batteryLevel;
    });
  }

  Future<void> runService() async {
    // String batteryLevel;
    try {
      // final int result =
      await platform.invokeMethod('runService');
      // batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      throw e.toString();
      // batteryLevel = "Failed to get battery level: '${e.message}'.";
    }
  }
  Future<void> stopService() async {
    // String batteryLevel;
    try {
      // final int result =
      await platform.invokeMethod('stopService');
      // batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      throw e.toString();
      // batteryLevel = "Failed to get battery level: '${e.message}'.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: const Text('Get Battery Level'),
              onPressed: getBatteryLevel,
            ),
            Text(batteryLevel),
            ElevatedButton(
              child: const Text('start service'),
              onPressed: runService,
            ),
            ElevatedButton(
              child: const Text('stop service'),
              onPressed: runService,
            ),
          ],
        ),
      ),
    );
  }
}
