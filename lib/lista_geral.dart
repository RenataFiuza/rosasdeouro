import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'aluno.dart';
import 'oficina.dart';


class ListaGeral extends StatefulWidget {
  const ListaGeral({super.key});

  @override
  State<ListaGeral> createState() => _ListaGeralState();
}

class _ListaGeralState extends State<ListaGeral> {
  late List<Aluno> alunos;
  late List<Oficina> oficinas;
  late List<Map<String, dynamic>> inscricoes;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    final db = await DatabaseHelper().database;
    final alunoData = await db.query('aluno');
    final oficinaData = await db.query('oficina');
    final inscricoesData = await db.query('cadastro');

    setState(() {
      alunos = alunoData.map((data) => Aluno.fromMap(data)).toList();
      oficinas = oficinaData.map((data) => Oficina.fromMap(data)).toList();
      inscricoes = inscricoesData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Listagem Geral')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Alunos'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => AlunoListScreen(alunos)));
            },
          ),
          ListTile(
            title: const Text('Oficinas'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => OficinaListScreen(oficinas)));
            },
          ),
          ListTile(
            title: const Text('Inscrições'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => InscricaoListScreen(inscricoes)));
            },
          ),
        ],
      ),
    );
  }
}

class AlunoListScreen extends StatelessWidget {
  final List<Aluno> alunos;
  const AlunoListScreen(this.alunos, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Alunos')),
      body: ListView.builder(
        itemCount: alunos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(alunos[index].nome),
          );
        },
      ),
    );
  }
}

class OficinaListScreen extends StatelessWidget {
  final List<Oficina> oficinas;
  const OficinaListScreen(this.oficinas, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Oficinas')),
      body: ListView.builder(
        itemCount: oficinas.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(oficinas[index].nomeOficina),
            subtitle: Text('Vagas: ${oficinas[index].vagasDisponiveis}'),
          );
        },
      ),
    );
  }
}

class InscricaoListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> inscricoes;
  const InscricaoListScreen(this.inscricoes, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Inscrições')),
      body: ListView.builder(
        itemCount: inscricoes.length,
        itemBuilder: (context, index) {
          final inscricao = inscricoes[index];
          return ListTile(
            title: Text('Aluno ID: ${inscricao['id_aluno']} - Oficina ID: ${inscricao['id_oficina']}'),
            subtitle: Text('Data: ${inscricao['data_cadastro']}'),
          );
        },
      ),
    );
  }
}
