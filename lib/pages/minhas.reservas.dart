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
                    backgroundImage: AssetImage("estacionamentos/"+estacionamentos[index]["imagem"]),
                    backgroundColor: Colors.white,
                  ),
                  title: Text(estacionamentos[index]["nome"]),
                  subtitle: Text(estacionamentos[index]["endereco"]),
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
              Card(
                  child: ListTile(
                title: Text("4 Folhas"),
                subtitle: Text("Av. Saudade 205"),
                leading: CircleAvatar(
                  child: Image.asset("estacionamentos/4folhas.png"),
                ),
                trailing: Text(
                  'Pendente',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () => _navigateToDetalheReserva(context),
              )),
              SizedBox(
                height: 20,
              ),
              Card(
                  child: ListTile(
                title: Text("2 Pinheiros"),
                subtitle: Text("Av. Sampaio Vidal 1537"),
                leading: CircleAvatar(
                  child: Image.asset("estacionamentos/2pinheiros.jpg"),
                ),
                trailing: Text(
                  'Finalizada',
                  style: TextStyle(color: Colors.green),
                ),
                onTap: () => _navigateToDetalheReserva(context),
              )),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 400,
                child: ListaReservas()
              ),
            ],
          ),
        ));
  }

  void _navigateToDetalheReserva(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => DetalheReservaPage()));
  }
}
