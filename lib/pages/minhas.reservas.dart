import 'package:park_here/pages/detalhe.reserva.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:park_here/components/carregar_comp.dart';
import "package:shared_preferences/shared_preferences.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> callAsyncFetch() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var idUsuario = prefs.getInt('usuarioId').toString();

  final response = await http.get(Uri.parse('https://parkhere-api.herokuapp.com/reserva/usuario/'+idUsuario));

  return response.body;
}

class ListaReservas extends StatelessWidget {

  setDadosReserva(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('IdReserva', id);
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
    saida = hora + "hs";

    return saida;
  }

  @override
  Widget build(context) {
    return FutureBuilder<String>(
      future: callAsyncFetch(),
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          
          Map<String, dynamic> myMap = json.decode(snapshot.data);
          List<dynamic> estacionamentos = myMap["data"];
          
          return ListView.separated(
            padding: const EdgeInsets.all(0),
            itemCount: estacionamentos.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("assets/estacionamentos/"+estacionamentos[index]["imagem"]),
                    backgroundColor: Colors.white,
                  ),
                  title: Text(estacionamentos[index]["nome"]),
                  //subtitle: Text(estacionamentos[index]["endereco"]),
                  subtitle: Text(
                    mostraData(estacionamentos[index]["diaReserva"]) + " - " +
                    mostraHora(estacionamentos[index]["inicioReserva"])
                  ),
                  onTap: () => {
                    setDadosReserva(
                      estacionamentos[index]["idReserva"].toString()
                    ),
                    _navigateToDetalheReserva(context)
                  },
                  trailing: Text(
                    'Pendente',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(
              color: Colors.white,
              height: 2,
            ),
          );
        } else {
          return CarregarComponente();
        }
      }
    );
  }

  void _navigateToDetalheReserva(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => DetalheReservaPage()));
  }
}

class MinhasReservasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text('Minhas Reservas'),
            backgroundColor: Colors.black),
        body: Container(
          padding: EdgeInsets.only(top: 40, left: 40, right: 40),
          color: Colors.white,
          child: ListView(
            children: [
              SizedBox(
                height: 400,
                child: ListaReservas()
              ),
            ],
          ),
        ));
  }
}
