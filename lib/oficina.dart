class Oficina {
  int? id;
  String nomeOficina;
  int vagasDisponiveis;

  Oficina({this.id, required this.nomeOficina, required this.vagasDisponiveis});

  Map<String, dynamic> toMap() => {'id': id, 'nome_oficina': nomeOficina, 'vagas_disponiveis': vagasDisponiveis};
}
