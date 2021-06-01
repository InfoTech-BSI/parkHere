class Usuario {
  final int id;
  final String nome;
  final String nascimento;
  final String email;

  Usuario({
    this.id,
    this.nome,
    this.nascimento,
    this.email,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: int.parse(json['data'][0]['id'].toString()),
      nome: json['data'][0]['nome'].toString(),
      nascimento: json['data'][0]['nascimento'].toString(),
      email: json['data'][0]['email'].toString()
    );
  }
}