import 'package:flutter/material.dart';
import 'package:poetry_pages/screens/home.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
    theme: ThemeData(
      primaryColor:  Colors.orange,
    ),
  ));
}