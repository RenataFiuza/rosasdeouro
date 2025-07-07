class Aluno {
  int? id;
  String nome;
  String endereco;
  String telefone;

  Aluno({this.id, required this.nome, required this.endereco, required this.telefone});

  Map<String, dynamic> toMap() => {'id': id, 'nome': nome, 'endereco': endereco, 'telefone': telefone};
}
