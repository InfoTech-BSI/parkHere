import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:park_here/pages/landing.dart';
import 'package:park_here/pages/login.dart';
import 'package:park_here/pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      routes: {
        '/': (context) => Landing(),
        '/login': (context) => Login(),
        '/home': (context) => Home()
      },
    );
  }
}
