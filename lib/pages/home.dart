import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:park_here/components/carregar_comp.dart';
import "package:shared_preferences/shared_preferences.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

Future<String> callAsyncFetch() async{
  final response = await http.get(Uri.parse('http://localhost:3000/estacionamento/'));

  return response.body;
} 

class ListaEstacionamentos extends StatelessWidget {

  setDadosEstacionamento(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('IdEstacionamento', id);
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
            padding: const EdgeInsets.all(8),
            itemCount: estacionamentos.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage("estacionamentos/"+estacionamentos[index]["imagem"]),
                ),
                title: Text(estacionamentos[index]["nome"]),
                subtitle: Text(estacionamentos[index]["endereco"]),
                onTap: () => {
                  setDadosEstacionamento(estacionamentos[index]["id"].toString()),
                  Navigator.pushNamed(context, '/estacionamento')
                },
              );
            },
            separatorBuilder: (context, index) => Divider(
              color: Colors.black,
              height: 2,
            ),
          );
        } else {
          return CarregarComponente();
        }
      }
    );
  }
}

class _HomeState extends State<Home> {
  String usuario;

  @override
  void initState() {
    super.initState();
    getDadosUsuario();
  }

  getDadosUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      this.usuario = (prefs.getString('usuarioNome') ?? "");
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Localização"),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 60, left: 40, right: 40),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Escolha o estacionamento",
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 400,
                child: ListaEstacionamentos()
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                shape: CircleBorder(),
                color: Colors.yellow[600],
                padding: EdgeInsets.all(10),
                onPressed: () {
                  // Navigator.pushNamedAndRemoveUntil(context, "/estacionamento",
                  //     ModalRoute.withName('/estacionamento'));
                  Navigator.pushNamed(context, '/estacionamento');
                },
                child: Icon(
                  Icons.search,
                  size: 40,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
