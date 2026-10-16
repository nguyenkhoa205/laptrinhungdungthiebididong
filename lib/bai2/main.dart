import 'package:flutter/material.dart';
import 'package:app_nhom5/bai2/slider.dart'; // Trỏ tới file slider trong bai2

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MySliderPage(),
    );
  }
}