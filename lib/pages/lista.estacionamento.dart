import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:park_here/pages/estacionamento.dart';

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
              Card(
                  child: ListTile(
                title: Text("4 Folhas"),
                subtitle: Text("Av. Saudade 205"),
                leading: CircleAvatar(
                  child: Image.asset("assets/4folhas.png"),
                ),
                onTap: () => _navigateToEstacionamento(context),
              )),
              SizedBox(
                height: 20,
              ),
              Card(
                  child: ListTile(
                title: Text("2 Pinheiros"),
                subtitle: Text("Av. Sampaio Vidal 1537"),
                leading: CircleAvatar(
                  child: Image.asset("assets/2pinheiros.png"),
                ),
                onTap: () => _navigateToEstacionamento(context),
              )),
              SizedBox(
                height: 20,
              ),
              Card(
                  child: ListTile(
                title: Text("Giga"),
                subtitle: Text("Av. Pres. Tancredo de Almeida 50"),
                leading: CircleAvatar(
                  child: Image.asset("assets/giga.png"),
                ),
                onTap: () => _navigateToEstacionamento(context),
              )),
              SizedBox(
                height: 20,
              ),
              Card(
                  child: ListTile(
                title: Text("Riachuelo"),
                subtitle: Text("R. São Luiz 719"),
                leading: CircleAvatar(
                  child: Image.asset("assets/riachoelo.png"),
                ),
                onTap: () => _navigateToEstacionamento(context),
              )),
            ],
          ),
        ));
  }

  void _navigateToEstacionamento(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => EstacionamentoPage()));
  }
}
