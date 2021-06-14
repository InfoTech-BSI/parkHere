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

Future<String> callAsyncFetch() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var id = prefs.getString('IdEstacionamento');
  final response = await http.get(Uri.parse('http://localhost:3000/estacionamento/'+id));

  return response.body;
} 

class ListaEstacionamento extends StatelessWidget {

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

  mostraWhatsapp(String numero){

    if(numero == ""){
      return SizedBox(
        height: 10,
      );
    } else {
      return Container(
        child: Row(children: <Widget>[
          IconButton(
            iconSize: 40,
            icon: Image.asset(
              "whatsapp-logo.png",
              width: 50,
              height: 50
              ),
            color: Colors.white,
            onPressed: () {},
          ),
          Text(
            " "+numero,
            style: TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.left,
          ),
        ]),
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

          return Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Dados do estacionamento",
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
                      "Nome: " + 
                      estacionamento[0]["nome"],
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ])
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Row(children: <Widget>[
                    Text(
                      "Dias de funcionamento:",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ]),
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
                  height: 15,
                ),
                Container(
                  child: Row(children: <Widget>[
                    Text(
                      "Horário de funcionamento:",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ]),
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
                  height: 15,
                ),
                Container(
                  child: Row(children: <Widget>[
                    Text(
                      "Contato:",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ]),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Row(children: <Widget>[
                    IconButton(
                      iconSize: 40,
                      icon: Image.asset(
                        "phone.png",
                        width: 50,
                        height: 50
                        ),
                      color: Colors.white,
                      onPressed: () {},
                    ),
                    Text(
                      " "+estacionamento[0]["telefone"],
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ]),
                ),
                SizedBox(
                  height: 5,
                ),
                mostraWhatsapp(estacionamento[0]["whatsapp"]),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green[400],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "RESERVAR",
                          style: TextStyle(
                            fontSize: 32,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/reservar');
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

class EstacionamentoState extends State<EstacionamentoPage> {
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
        title: Text("Localização"),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: EdgeInsets.only(bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListaEstacionamento(),
          ],
        ),
      ),
    ),
    );
  }
}
