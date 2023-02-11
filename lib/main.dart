import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:graduation/modules/home/home_screen.dart';

void main() => runApp(
    // DevicePreview(builder: (context) =>
    const MyApp()
    // )
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
