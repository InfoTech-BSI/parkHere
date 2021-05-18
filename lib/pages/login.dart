import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:shared_preferences/shared_preferences.dart";

class Login extends StatefulWidget {
  @override
  LoginPage createState() => LoginPage();
}

class LoginPage extends State<Login> {
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String usuario = "";
  String senha = "";
  bool autoavaliacao = false;

  void MostrarMensagem(String msg) {
    scaffoldkey.currentState.showSnackBar(SnackBar(content: Text(msg)));
  }

  void Acessar() async {
    final FormState form = formKey.currentState;
    if (!form.validate()) {
      autoavaliacao = true;
      MostrarMensagem(
          'Dados inválidos detectados! Corrijá os campos em vermelho!');
    } else {
      form.save();
      if (usuario == "admin" && senha == "senha12345") {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('usuario', usuario);
        Navigator.pushNamedAndRemoveUntil(
            context, "/home", ModalRoute.withName('/home'));
      } else {
        MostrarMensagem('Usuário ou senha inválidos!');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldkey,
        body: Container(
          padding: EdgeInsets.only(top: 60, left: 40, right: 40),
          color: Colors.white,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 300,
                  height: 300,
                  child: Image.asset("assets/logo.PNG"),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  key: Key("mobile"),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.w400,
                          fontSize: 20)),
                  style: TextStyle(fontSize: 20),
                  onSaved: (String value) {
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
                          color: Colors.black38,
                          fontWeight: FontWeight.w400,
                          fontSize: 20)),
                  style: TextStyle(fontSize: 20),
                  onSaved: (String value) {
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
                    ),
                    onPressed: () => {},
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 60,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: [0.3, 1],
                            colors: [Color(0xFFF58524), Color(0XFFF92B7F)]),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: SizedBox.expand(
                      child: RaisedButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Login",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        onPressed: Acessar,
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 40,
                  child: TextButton(
                    child: Text(
                      "Cadastre-se",
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () => {},
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
