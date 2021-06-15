import 'package:park_here/pages/reserva.efetuada.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:park_here/components/carregar_comp.dart';
import "package:shared_preferences/shared_preferences.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';

class EstacionamentoPage extends StatefulWidget {
  @override
  EstacionamentoState createState() => EstacionamentoState();
}

Future<String> callAsyncFetch() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var id = prefs.getString('IdEstacionamento');
  final response =
      await http.get(Uri.parse('https://parkhere-api.herokuapp.com/estacionamento/' + id));

  return response.body;
}

class ListaEstacionamento extends StatelessWidget {
  String dropdownValue = 'Selecione o horário';
  String dropdownValueDia = 'Selecione o dia';
  
  void enviarReserva(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var idUsuario = prefs.getInt('usuarioId');
    var idEstacionamento = prefs.getString('IdEstacionamento');
    var inicioReserva = prefs.getString('inicioReserva');
    var fimReserva = prefs.getString('fimReserva');
    var diaReserva = prefs.getString('diaReserva');

    await http.post(Uri.parse('https://parkhere-api.herokuapp.com/reserva/'),headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },body: jsonEncode(<String, String>{
        'idUsuario': idUsuario.toString(),
        'idEstacionamento': idEstacionamento,
        'inicioReserva': inicioReserva,
        'fimReserva': fimReserva,
        'diaReserva': diaReserva,
        'atualizacao': DateTime.now().toString()
      })
    );

    _navigateToMensagem(context);
  }

  carregaDias(String dias) {
    var saida = dias;

    if (dias == "2-3-4-5") {
      saida = "Segunda-feira a Quinta-feira";
    } else if (dias == "2-3-4-5-6") {
      saida = "Segunda-feira a Sexta-feira";
    } else if (dias == "2-3-4-5-6-7") {
      saida = "Segunda-feira a Sábado";
    } else if (dias == "1-2-3-4-5-6-7") {
      saida = "Todos os dias";
    }

    return saida;
  }

  carregaHoras(String horas) {
    var hora = horas.split('-');
    var saida = "";

    saida = "Das " + hora[0] + " às " + hora[1] + " horas";

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
  
  converteDia(String tempo){
    var saida = "";
    
    var dia = tempo.substring(0,2);
    var mes = tempo.substring(3,5);
    saida = "2021-" + mes + "-" + dia;

    return saida;
  }
  
  void salvarData(data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('diaReserva', data);
  }
  
  
  List<String> geraHora(String horas){
    var saida = ['Selecione o horário'];
    var inicio = int.parse(horas.split('-')[0]);
    var fim = int.parse(horas.split('-')[1]);
    
    for (int i = inicio; i <= fim; i ++) {
      saida.add('$i:00');
    }
    
    return saida;
  }

  converteHora(String tempo){
    var saida = "00:00:00";

    if(tempo != "null") {
      var hora = tempo.substring(0,2);
      var minutos = tempo.substring(3,5);
      saida = hora + ":" + minutos + ":00";
    }

    return saida;
  }

  void salvarHoraInicio(String hora) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('inicioReserva', hora);
  }

  void salvarHoraFim(String hora) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('fimReserva', hora);
  }

  @override
  Widget build(context) {
    return FutureBuilder<String>(
      future: callAsyncFetch(),
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic> myMap = json.decode(snapshot.data);

          List<dynamic> estacionamento = myMap["data"];

          return Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Informações',
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Dias de funcionamento:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Row(children: <Widget>[
                    Text(
                      carregaDias(estacionamento[0]["dias_funciona"]),
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ]),
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
                Container(
                  child: Row(children: <Widget>[
                    Text(
                      carregaHoras(estacionamento[0]["horas_funciona"]),
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ]),
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
                  height: 20,
                ),
                DropdownButtonFormField(
                  value: dropdownValueDia,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  items: <String>['Selecione o dia', '15/06/2021', '16/06/2021', '17/06/2021']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String newValue) {
                    print(converteDia(newValue));
                    salvarData(converteDia(newValue));
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  items: geraHora(estacionamento[0]["horas_funciona"])
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String newValue) {
                    print(converteHora(newValue));
                    salvarHoraInicio(converteHora(newValue));
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                DropdownButtonFormField(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  items: geraHora(estacionamento[0]["horas_funciona"])
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String newValue) {
                    print(converteHora(newValue));
                    salvarHoraFim(converteHora(newValue));
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.green[400],
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: TextButton(
                    child: Text(
                      "Reservar",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    onPressed: () => {
                      enviarReserva(context)
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return CarregarComponente();
        }
      }
    );
  }

  void _navigateToMensagem(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ReservaEfetuadaPage()));
  }
}

class EstacionamentoState extends State<EstacionamentoPage> {
  String _estacionamento = 'Carregando';

  @override
  void initState() {
    super.initState();
    toggleTitulo();
  }

  Future<void> toggleTitulo() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var nome = prefs.getString('NomeEstacionamento');

    setState(() {
      _estacionamento = nome;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text('$_estacionamento'),
          backgroundColor: Colors.black),
      body: Container(
        padding: EdgeInsets.only(top: 20, left: 30, right: 30),
        color: Colors.white,
        child: ListaEstacionamento(),
      ),
    );
  }
}
