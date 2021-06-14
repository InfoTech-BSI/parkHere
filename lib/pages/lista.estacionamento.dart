import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:park_here/components/carregar_comp.dart';
import "package:shared_preferences/shared_preferences.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:park_here/pages/estacionamento.dart';

Future<String> callAsyncFetch() async{
  final response = await http.get(Uri.parse('http://localhost:3000/estacionamento/'));

  return response.body;
}

class ListaEstacionamentos extends StatelessWidget {

  setDadosEstacionamento(String id, String nome) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('IdEstacionamento', id);
    prefs.setString('NomeEstacionamento', nome);
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
                    setDadosEstacionamento(
                      estacionamentos[index]["id"].toString(),
                      estacionamentos[index]["nome"]
                    ),
                    _navigateToEstacionamento(context)
                  },
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

  void _navigateToEstacionamento(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => EstacionamentoPage()));
  }
}

class ListaEstacionamentosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Lista de Estabelecimentos'),
        backgroundColor: Colors.black),
      body: Container(
        padding: EdgeInsets.only(top: 40, left: 40, right: 40),
        color: Colors.white,
        child: ListView(
          children: [
            SizedBox(
              height: 400,
              child: ListaEstacionamentos()
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      )
    );
  }
}
