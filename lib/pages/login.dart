import 'package:park_here/pages/cadastro.dart';
import 'package:park_here/pages/home.dart';
import 'package:park_here/pages/recuperarSenha.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import "package:shared_preferences/shared_preferences.dart";
import 'package:http/http.dart' as http;
import '../class/usuario.dart';
import 'dart:convert';

class LoginPage extends StatelessWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldkey =
      GlobalKey<ScaffoldMessengerState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String usuario = "";
  String senha = "";
  bool autoavaliacao = false;

  void mostrarMensagem(String msg) {
    scaffoldkey.currentState.showSnackBar(SnackBar(content: Text(msg)));
  }

  void Acessar(BuildContext context) async {
    final FormState form = formKey.currentState;

    final response = await http.post(Uri.parse('http://localhost:3000/login/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'Email': usuario, 'Senha': senha}));

    if (!form.validate()) {
      autoavaliacao = true;
      mostrarMensagem(
          'Dados inválidos detectados! Corrijá os campos em vermelho!');
    } else {
      form.save();

      if (response.body.contains("Login feito com sucesso!")) {
        Usuario user = Usuario.fromJson(jsonDecode(response.body));
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt('usuarioId', user.id);
        prefs.setString('usuarioNome', user.nome);
        prefs.setString('usuarioEmail', user.email);
        prefs.setString('usuarioNascimento', user.nascimento);
        _navigateToHome(context);
      } else {
        mostrarMensagem('Usuário ou senha inválidos!');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 40, left: 40, right: 40),
        color: Colors.white,
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 300,
                height: 300,
                child: Image.asset("assets/logo.png"),
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
                onChanged: (String value) {
                  usuario = value;
                },
              ),
              SizedBox(
                height: 20,
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
                onChanged: (String value) {
                  senha = value;
                },
              ),
              Container(
                height: 40,
                alignment: Alignment.centerRight,
                child: TextButton(
                  child: Text(
                    "Recuperar Senha",
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  onPressed: () => {_navigateToRecuperarSenha(context)},
                ),
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
                    "Login",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () => {Acessar(context)},
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 40,
                child: TextButton(
                  child: Text(
                    "Cadastre-se",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  onPressed: () => {_navigateToCadastro(context)},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToHome(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => HomePage()));
  }

  void _navigateToCadastro(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => CadastroPage()));
  }

  void _navigateToRecuperarSenha(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => RecuperarSenhaPage()));
  }
}
