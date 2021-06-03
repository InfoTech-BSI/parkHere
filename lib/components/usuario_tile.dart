import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:park_here/models/usuario.dart';
import 'package:park_here/provider/usuarios.dart';
import 'package:provider/provider.dart';

class UsuarioTile extends StatelessWidget {
  final Usuario usuario;

  const UsuarioTile(this.usuario);
  @override
  Widget build(BuildContext context) {
    final avatar = usuario.avatarUrl == null || usuario.avatarUrl.isEmpty
        ? CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(backgroundImage: NetworkImage(usuario.avatarUrl));
    return ListTile(
      leading: avatar,
      title: Text(usuario.nome),
      subtitle: Text(usuario.email),
      trailing: Container(
        width: 100,
        child: Row(children: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.delete),
            color: Colors.red,
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text('Excluir Usuário'),
                  content: Text('Tem Certeza?'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Não'),
                    ),
                    FlatButton(
                      onPressed: () {
                        Provider.of<Usuarios>(context, listen: false)
                            .remove(usuario);
                        Navigator.of(context).pop();
                      },
                      child: Text('SIM'),
                    ),
                  ],
                ),
              );
            },
          ),
        ]),
      ),
    );
  }
}
