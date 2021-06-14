import 'package:park_here/pages/reserva.cancelada.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetalheReservaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text('Detalhes da Reserva'),
            backgroundColor: Colors.black),
        body: Container(
          padding: EdgeInsets.only(top: 40, left: 40, right: 40),
          color: Colors.white,
          child: ListView(children: <Widget>[
            Text(
              'Estabelecimento',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            Text(
              '4 Folhas',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Data',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            Text(
              '08/06/2021',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Horário',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            Text(
              '15h',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Contatos:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            Card(
                child: ListTile(
              title: Text("(14) 3456-8650"),
              leading: CircleAvatar(
                child: Image.asset("assets/telefone.png"),
              ),
            )),
            SizedBox(
              height: 5,
            ),
            Card(
                child: ListTile(
              title: Text("(14) 99456-4386"),
              leading: CircleAvatar(
                child: Image.asset("assets/whats.png"),
              ),
            )),
            SizedBox(
              height: 40,
            ),
            SizedBox(
              width: 150,
              height: 150,
              child: Image.asset("assets/qrcode.png"),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.red[400],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: TextButton(
                child: Text(
                  "Cancelar Reserva",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                onPressed: () => {_navigateToMensagem(context)},
              ),
            )
          ]),
        ));
  }

  void _navigateToMensagem(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ReservaCanceladaPage()));
  }
}
