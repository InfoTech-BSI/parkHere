import 'package:park_here/pages/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecuperarSenhaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text('Esqueci a Senha'),
            backgroundColor: Colors.black),
        body: Container(
            padding: EdgeInsets.only(top: 40, left: 40, right: 40),
            color: Colors.white,
            child: ListView(children: <Widget>[
              SizedBox(
                width: 300,
                height: 300,
                child: Image.asset("assets/logo.png"),
              ),
              Text(
                'Para redefinir sua senha, informe o email cadastrado na sua conta e lhe enviaremos um link com as instruções.',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
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
                height: 20,
              ),
              Container(
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.yellow[800],
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: TextButton(
                  child: Text(
                    "Enviar",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () => {_navigateToLogin(context)},
                ),
              ),
            ])));
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
