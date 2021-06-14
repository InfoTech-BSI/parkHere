import 'package:park_here/pages/detalhe.reserva.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                  child: Image.asset("assets/4folhas.png"),
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
                  child: Image.asset("assets/2pinheiros.png"),
                ),
                trailing: Text(
                  'Finalizada',
                  style: TextStyle(color: Colors.green),
                ),
                onTap: () => _navigateToDetalheReserva(context),
              )),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ));
  }

  void _navigateToDetalheReserva(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => DetalheReservaPage()));
  }
}
