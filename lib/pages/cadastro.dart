import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:park_here/pages/home.dart';

class CadastroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Cadastre-se", textAlign: TextAlign.center),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.only(top: 10, left: 40, right: 40),
          color: Colors.white,
          child: ListView(children: <Widget>[
            SizedBox(
              width: 250,
              height: 250,
              child: Image.asset("assets/logo.png"),
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: 'Nome',
                  labelStyle: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                      fontSize: 20)),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: 'Data de Nascimento',
                  labelStyle: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                      fontSize: 20)),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                      fontSize: 20)),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                  labelText: 'Senha',
                  labelStyle: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                      fontSize: 20)),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                  labelText: 'Confirmação de Senha',
                  labelStyle: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                      fontSize: 20)),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.yellow[800],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: TextButton(
                child: Text(
                  "Cadastrar",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => {_navigateToHome(context)},
              ),
            )
          ]),
        ));
  }

  void _navigateToHome(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => HomePage()));
  }
}
