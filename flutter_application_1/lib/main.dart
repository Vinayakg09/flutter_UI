import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home.dart';
 
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter layout demo',
      home: Home(testValue: " "),
    );
  }
}
