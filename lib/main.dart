import 'package:blue_scan/screens/scanner.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blue Scan',
      home: Scanner(),
      theme: ThemeData(
        backgroundColor: Colors.white,
        primaryColor: Colors.blue.shade900,
        accentColor: Colors.blue,
        textTheme: TextTheme(bodyText2: TextStyle(fontSize: 20)),
      ),
    );
  }
}
