import 'package:park_here/pages/login.dart';
import 'package:park_here/pages/minhas.reservas.dart';
import 'package:park_here/pages/editar.usuario.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:shared_preferences/shared_preferences.dart";

class MinhaContaPage extends StatefulWidget {
  @override
  MinhaContaState createState() => MinhaContaState();
}

class MinhaContaState extends State<MinhaContaPage> {
  String _nome = 'Carregando';

  @override
  void initState() {
    super.initState();
    toggleTitulo();
  }

  Future<void> toggleTitulo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var nome = prefs.getString('usuarioNome');

    setState(() {
      _nome = nome;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text('Minha Conta'),
            backgroundColor: Colors.black),
        body: Container(
          padding: EdgeInsets.only(top: 40, left: 40, right: 40),
          color: Colors.white,
          child: ListView(children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                size: 100,
                color: Colors.black87,
              ),
              radius: 50,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              _nome,
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30,
            ),
            ListTile(
              title: Text("Editar Cadastro"),
              leading: Icon(Icons.edit),
              onTap: () => _navigateToEditar(context),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              title: Text("Minhas Reservas"),
              leading: Icon(Icons.car_rental),
              onTap: () => _navigateToMinhasReservas(context),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
                title: Text("Avisos"), leading: Icon(Icons.article_rounded)),
            SizedBox(
              height: 140,
            ),
            Container(
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.yellow[800],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: TextButton(
                child: Text(
                  "Sair",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => {_navigateToLogin(context)},
              ),
            ),
          ]),
        ));
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginPage()));
  }

  void _navigateToMinhasReservas(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => MinhasReservasPage()));
  }

  void _navigateToEditar(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => EditarUsuarioPage()));
  }
}
