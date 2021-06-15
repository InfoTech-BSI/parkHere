import 'package:park_here/pages/reserva.cancelada.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:park_here/components/carregar_comp.dart';
import "package:shared_preferences/shared_preferences.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> callAsyncFetch() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var id = prefs.getString('IdReserva');
  final response =
      await http.get(Uri.parse('https://parkhere-api.herokuapp.com/reserva/' + id));

  return response.body;
}

class ListaReserva extends StatelessWidget {
  
  void cancelarReserva(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var idReserva = prefs.getString('IdReserva');

    await http.delete(Uri.parse('https://parkhere-api.herokuapp.com/reserva/' + idReserva));

    _navigateToMensagem(context);
  }

  mostraData(String tempo) {
    var saida = "";
    
    var dia = tempo.substring(8,10);
    var mes = tempo.substring(5,7);
    var ano = tempo.substring(0,4);
    saida = dia + "/" + mes + "/" + ano;

    return saida;
  }

  mostraHora(String hora) {
    var saida = "";
    
    hora = hora.substring(0,2);
    saida = hora + "h";

    return saida;
  }

  mostraWhatsapp(String numero) {
    if (numero == "") {
      return SizedBox(
        height: 0,
      );
    } else {
      return Card(
        child: ListTile(
          title: Text(numero),
          leading: CircleAvatar(
            backgroundColor: Colors.white,
            child: Image.asset("whats.png"),
          ),
        )
      );
    }
  }

  @override
  Widget build(context) {
    return FutureBuilder<String>(
      future: callAsyncFetch(),
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic> myMap = json.decode(snapshot.data);

          List<dynamic> estacionamento = myMap["data"];

          return ListView(
            shrinkWrap: true,
            children: <Widget>[
            Text(
              'Estabelecimento',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            Text(
              estacionamento[0]["nome"],
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
              mostraData(estacionamento[0]["diaReserva"]),
              style: TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Horário:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              mostraHora(estacionamento[0]["inicioReserva"]) + " às " + mostraHora(estacionamento[0]["fimReserva"]),
              style: TextStyle(
                fontSize: 20,
              ),
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
            SizedBox(
              height: 10,
            ),
            Card(
              child: ListTile(
                title: Text(estacionamento[0]["telefone"]),
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Image.asset("phone.png"),
                ),
              )
            ),
            SizedBox(
              height: 5,
            ),
            mostraWhatsapp(estacionamento[0]["whatsapp"]),
            SizedBox(
              height: 40,
            ),
            SizedBox(
              width: 150,
              height: 150,
              child: Image.asset("qrcode.png"),
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
                onPressed: () => {cancelarReserva(context)},
              ),
            ),
          ]);
        } else {
          return CarregarComponente();
        }
      }
    );
  }

  void _navigateToMensagem(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ReservaCanceladaPage()));
  }
}

class DetalheReservaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text('Detalhes da Reserva'),
          backgroundColor: Colors.black),
      body: Container(
        padding: EdgeInsets.only(top: 30, left: 40, right: 40),
        color: Colors.white,
        child: ListView(children: <Widget>[
          SizedBox(
            child: ListaReserva()
          ),
        ]),
      ),
    );
  }
}
