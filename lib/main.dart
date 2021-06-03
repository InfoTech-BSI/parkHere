import 'package:flutter/material.dart';
import 'package:park_here/pages/login.dart';
import 'package:park_here/provider/usuarios.dart';
import 'package:park_here/routes/app_routs.dart';
import 'package:park_here/views/usuario_form.dart';
import 'package:provider/provider.dart';

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
        home: LoginPage(),
        routes: {AppRoutes.USUARIO_FORM: (ctx) => UsuarioForm()},
      ),
    );
  }
}
