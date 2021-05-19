import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:shared_preferences/shared_preferences.dart";

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String usuario;

  @override
  void initState() {
    super.initState();
    getDadosUsuario();
  }

  getDadosUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      this.usuario = (prefs.getString('usuario') ?? "");
    });
  }

  void Logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('usuario');
    Navigator.pushNamedAndRemoveUntil(
        context, "/login", ModalRoute.withName('/login'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Localização"),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 60, left: 40, right: 40),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Escolha o estacionamento",
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                width: 300,
                height: 300,
                child: Image.asset("assets/mapa.PNG"),
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                shape: CircleBorder(),
                color: Colors.yellow[600],
                padding: EdgeInsets.all(10),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, "/estacionamento",
                      ModalRoute.withName('/estacionamento'));
                },
                child: Icon(
                  Icons.search,
                  size: 40,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
