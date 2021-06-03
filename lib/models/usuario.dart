import 'package:flutter/cupertino.dart';

class Usuario {
  final String id;
  final String nome;
  final String dataNascimento;
  final String email;
  final String senha;
  final String avatarUrl;

  const Usuario(
      {this.id,
      @required this.nome,
      @required this.dataNascimento,
      @required this.email,
      @required this.senha,
      @required this.avatarUrl});
}
