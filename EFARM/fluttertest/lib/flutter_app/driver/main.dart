
import 'package:flutter/material.dart';
import 'package:fluttertest/flutter_app/driver/driver_home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Driver App",
      home: DriverHome(),
    );
  }
}
