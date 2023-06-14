import 'package:flutter/material.dart';
import 'login.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false,
    title: 'FINAL PROJECT',
    home: const Login(),
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: const Color(0xffDA124B),

    ),
    ),
  );
}


