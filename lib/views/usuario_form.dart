import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:park_here/models/usuario.dart';
import 'package:park_here/pages/login.dart';

class UsuarioForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final Map<Object, Object> _formData = {};
  void _loadFormData(Usuario usuario) {
    if (usuario != null) {
      _formData['id'] = usuario.id;
      _formData['nome'] = usuario.nome;
      _formData['dataNascimento'] = usuario.dataNascimento;
      _formData['email'] = usuario.email;
      _formData['senha'] = usuario.senha;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Usuario usuario = ModalRoute.of(context).settings.arguments;

    _loadFormData(usuario);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastre-se'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                    width: 180,
                    height: 180,
                    child: Image.asset('logo.png')),
                TextFormField(
                    initialValue: _formData['nome'],
                    decoration: InputDecoration(labelText: 'Nome'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Nome invalido!';
                      }
                      if (value.trim().length < 3) {
                        return 'Nome deve ser maior que 3 letras';
                      }
                      return null;
                    },
                    onSaved: (value) => _formData['nome'] = value
                    //print(value);
                    ),
                TextFormField(
                  initialValue: _formData['Data Nascimento'],
                  decoration: InputDecoration(labelText: 'Data Nascimento'),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null) {
                      return 'Digite o campo email';
                    }
                    if (!value.contains("@")) {
                      return 'Email não tem @';
                    }
                    return null;
                  },
                  initialValue: _formData['email'],
                  decoration: InputDecoration(labelText: 'Email'),
                  onSaved: (value) => _formData['email'] = value,
                ),
                TextFormField(
                  obscureText: true,
                  initialValue: _formData['senha'],
                  decoration: InputDecoration(labelText: 'Senha'),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Senha invalida!';
                    }
                    if (value.trim().length < 1 && value.trim().length > 10) {
                      return 'Senha deve ser maior que 3 caracteres e menor que 10';
                    }
                    return null;
                  },
                  obscureText: true,
                  initialValue: _formData['senha'],
                  decoration: InputDecoration(labelText: 'Confirmar Senha'),
                ),
                Container(
                  height: 40,
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    child: Text(
                      "Recuperar Senha",
                      textAlign: TextAlign.right,
                    ),
                    onPressed: () {},
                  ),
                ),
                Container(
                  height: 60,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.3, 1],
                      colors: [
                        Color(0xFFFFAB00),
                        Color(0xFFFFC400),
                      ],
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: SizedBox.expand(
                    child: FlatButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Cadastrar",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      onPressed: () => {},
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
