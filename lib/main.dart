import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:park_here/pages/landing.dart';
import 'package:park_here/pages/login.dart';
import 'package:park_here/provider/usuarios.dart';
import 'package:park_here/routes/app_routs.dart';
import 'package:park_here/views/usuario_form.dart';
import 'package:provider/provider.dart';
import 'package:park_here/pages/home.dart';
import 'package:park_here/pages/estacionamento.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Usuarios(),
        ),
      ],
      child: MaterialApp(
        title: 'App Login',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.grey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Login(),
        routes: {
          AppRoutes.USUARIO_FORM: (ctx) => UsuarioForm(),
          //'/': (context) => Landing(),
          '/login': (context) => Login(),
          '/home': (context) => Home(),
          '/estacionamento': (context) => Estacionamento(),
          //'/cadastro': (context) => Cadastro()
        },
      ),
    );
  }
}
