import 'package:park_here/pages/minhaConta.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditarUsuarioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Editar Cadastro", textAlign: TextAlign.center),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.only(top: 10, left: 40, right: 40),
          color: Colors.white,
          child: ListView(children: <Widget>[
            SizedBox(
              height: 60,
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(
                "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg",
              ),
              radius: 50,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              initialValue: 'Alice James',
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
              initialValue: '09/06/1990',
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
              initialValue: 'alice@gmail.com',
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
                  "Salvar",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => {_navigateToMinhaConta(context)},
              ),
            )
          ]),
        ));
  }

  void _navigateToMinhaConta(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => MinhaContaPage()));
  }
}
