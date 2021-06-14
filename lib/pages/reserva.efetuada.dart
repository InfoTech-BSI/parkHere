import 'package:park_here/pages/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReservaEfetuadaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text('Reserva'),
            backgroundColor: Colors.black),
        body: Container(
          padding: EdgeInsets.only(top: 300, left: 40, right: 40),
          color: Colors.white,
          child: ListView(children: <Widget>[
            Text(
              'Reserva efetuada com sucesso!',
              style: TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
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
                  "OK",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 20),
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
