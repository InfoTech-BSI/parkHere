import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:park_here/data/dummy.usuarios.dart';
import 'package:park_here/models/usuario.dart';

class Usuarios with ChangeNotifier {
  final Map<String, Usuario> _items = {...DUMMY_USUARIOS};

  List<Usuario> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  Usuario byIndex(int i) {
    return _items.values.elementAt(i);
  }

  void put(Usuario usuario) {
    if (usuario == null) {
      return;
    }
    if (usuario.id != null &&
        usuario.id.trim().isNotEmpty &&
        _items.containsKey(usuario.id)) {
      _items.update(usuario.id, (_) => usuario);
    } else {
      final id = Random().nextDouble().toString();
      _items.putIfAbsent(
          id,
          () => Usuario(
                id: id,
                dataNascimento: usuario.dataNascimento,
                nome: usuario.nome,
                email: usuario.email,
                senha: usuario.senha,
                avatarUrl: usuario.avatarUrl,
              ));
    }
    notifyListeners();
  }

  void remove(Usuario usuario) {
    if (usuario != null && usuario.id != null) {
      _items.remove(usuario.id);
      notifyListeners();
    }
  }
}
