import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:park_here/components/carregar_comp.dart';
import "package:shared_preferences/shared_preferences.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class Reservar extends StatefulWidget {
  @override
  ReservarState createState() => ReservarState();
}

Future<String> callAsyncFetch() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var id = prefs.getString('IdEstacionamento');
  final response = await http.get(Uri.parse('http://localhost:3000/estacionamento/'+id));

  return response.body;
}

void EnviarReserva() async {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var idUsuario = prefs.getInt('usuarioId');
  var idEstacionamento = prefs.getString('IdEstacionamento');
  var inicioReserva = prefs.getString('inicioReserva');
  var fimReserva = prefs.getString('fimReserva');
  var diaReserva = prefs.getString('diaReserva');

  await http.post(Uri.parse('http://localhost:3000/reserva/'),headers: <String, String>{
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
}

carregaDias(String tempo){
  var saida = DateTime.now().toString();

  if(tempo == "null") {
    tempo = saida;
  }
  
  var ano = tempo.substring(0,4);
  var mes = tempo.substring(5,7);
  var dia = tempo.substring(8,10);
  saida = ano + "-" + mes + "-" + dia;

  return saida;
}

carregaHoras(String tempo){
  var saida = "00:00:00";

  if(tempo != "null") {
    var hora = tempo.substring(11,13);
    var minutos = tempo.substring(14,16);
    saida = hora + ":" + minutos + ":00";
  }

  return saida;
}

class DateReservaField extends StatelessWidget {
  final format = DateFormat("dd/MM/yyyy");

  void salvarData(data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('diaReserva', data);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      //Text('Basic date field (${format.pattern})'),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(2021),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
        onChanged: (currentValue) {
          print(carregaDias(currentValue.toString()));
          salvarData(carregaDias(currentValue.toString()));
        },
      ),
    ]);
  }
}

class TimeReservaInicioField extends StatelessWidget {
  final format = DateFormat("HH:mm");

  void salvarHora(hora) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('inicioReserva', hora);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async {
          final TimeOfDay time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          return time == null ? null : DateTimeField.convert(time);
        },
        onChanged: (currentValue) {
          print(carregaHoras(currentValue.toString()));
          salvarHora(carregaHoras(currentValue.toString()));
        },
      ),
    ]);
  }
}

class TimeReservaFimField extends StatelessWidget {
  final format = DateFormat("HH:mm");

  void salvarHora(hora) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('fimReserva', hora);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async {
          final TimeOfDay time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          return time == null ? null : DateTimeField.convert(time);
        },
        onChanged: (currentValue) {
          print(carregaHoras(currentValue.toString()));
          salvarHora(carregaHoras(currentValue.toString()));
        },
      ),
    ]);
  }
}

class ListaReservar extends StatelessWidget {

  carregaDias(String dias){
    var saida = dias;
    
    if (dias == "2-3-4-5"){
      saida = "Segunda-feira a Quinta-feira";
    } else if (dias == "2-3-4-5-6"){
      saida = "Segunda-feira a Sexta-feira";
    } else if (dias == "2-3-4-5-6-7"){
      saida = "Segunda-feira a Sabádo";
    } else if (dias == "1-2-3-4-5-6-7"){
      saida = "Todos os dias";
    }

    return saida;
  }

  carregaHoras(String horas){
    var hora = horas.split('-');
    var saida = "";
    
    saida = "Das " + hora[0] + " às " + hora[1] + " horas";

    return saida;
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
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Dados da reserva",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Row(children: <Widget>[
                    Text(
                      "Nome: " + estacionamento[0]["nome"],
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ])
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Row(children: <Widget>[
                    Text(
                      "Data da reserva: ",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      width: 150,
                      child: 
                      DateReservaField(),
                    ),
                  ]),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Row(children: <Widget>[
                    Text(
                      "Início da reserva: ",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      width: 100,
                      child: 
                      TimeReservaInicioField(),
                    ),
                  ]),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Row(children: <Widget>[
                    Text(
                      "Fim da reserva: ",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      width: 100,
                      child: 
                      TimeReservaFimField(),
                    ),
                  ]),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: 250,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green[400],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "CONFIRMAR",
                          style: TextStyle(
                            fontSize: 32,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    onPressed: () {
                      EnviarReserva();
                    },
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.yellow[600],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "VOLTAR",
                          style: TextStyle(
                            fontSize: 32,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    onPressed: () => Navigator.pop(context),
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
}

class ReservarState extends State<Reservar> {
  String usuario;

  @override
  void initState() {
    super.initState();
    getDadosUsuario();
  }

  getDadosUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      this.usuario = (prefs.getString('usuario') ?? "");
    });
  }

  void Logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('usuario');
    Navigator.pushNamedAndRemoveUntil(
        context, "/login", ModalRoute.withName('/login'));
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
    onWillPop: () async => false,
    child: new Scaffold(
      appBar: AppBar(
        title: Text("Reservar"),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: EdgeInsets.only(bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListaReservar(),
          ],
        ),
      ),
    ),
    );
  }
}
