class Cadastro {
  int? id;
  int idAluno;
  int idOficina;
  String dataCadastro;

  Cadastro({this.id, required this.idAluno, required this.idOficina, required this.dataCadastro});

  Map<String, dynamic> toMap() => {'id': id, 'id_aluno': idAluno, 'id_oficina': idOficina, 'data_cadastro': dataCadastro};
}
