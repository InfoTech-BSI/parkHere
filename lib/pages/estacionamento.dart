import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:shared_preferences/shared_preferences.dart";

class Estacionamento extends StatefulWidget {
  @override
  EstacionamentoState createState() => EstacionamentoState();
}

class EstacionamentoState extends State<Estacionamento> {
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
      appBar: AppBar(
        title: Text("Localização"),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 60, left: 40, right: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Dados do estacionamento",
              style: TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Row(children: <Widget>[
                Text(
                  "Nome: 4 folhas",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.left,
                ),
              ]),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Row(children: <Widget>[
                Text(
                  "Dias de funcionamento:",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.left,
                ),
              ]),
            ),
            Container(
              child: Row(children: <Widget>[
                Text(
                  "Segunda-feira a Sabádo:",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.left,
                ),
              ]),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Row(children: <Widget>[
                Text(
                  "Horário de funcionamento:",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.left,
                ),
              ]),
            ),
            Container(
              child: Row(children: <Widget>[
                Text(
                  "Das 8 às 18 horas",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.left,
                ),
              ]),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Row(children: <Widget>[
                Text(
                  "Contato:",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.left,
                ),
              ]),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Row(children: <Widget>[
                Icon(
                  Icons.phone,
                  size: 20,
                ),
                Text(
                  "(14) 3456-8650:",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.left,
                ),
              ]),
            ),
            Container(
              child: Row(children: <Widget>[
                Icon(
                  Icons.phone,
                  size: 20,
                ),
                Text(
                  "(14) 99456-4386",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.left,
                ),
              ]),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.yellow[600],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "RESERVAR",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              onPressed: () {},
            ),
            SizedBox(
              height: 7,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.yellow[600],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "VOLTAR",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
