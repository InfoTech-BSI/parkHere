import 'package:flutter/material.dart';
import "package:shared_preferences/shared_preferences.dart";

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

//SharedPreferences prefs = await SharedPreferences.getInstance();

class _LandingState extends State<Landing> {
  String usuario = '';

  @override
  void initState() {
    super.initState();
    autoLogin();
  }

  autoLogin() async {
    SharedPreferences pref_login = await SharedPreferences.getInstance();
    String usuario = (pref_login.getString('usuario') ?? '');

    if (usuario == '') {
      Navigator.pushNamedAndRemoveUntil(
          context, "/login", ModalRoute.withName('/login'));
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, "/home", ModalRoute.withName('/home'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
