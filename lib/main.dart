import 'package:flutter/material.dart';
import 'package:undergrounder/screens/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: "undergrounder",
      home: HomePage(),
    );
  }
}