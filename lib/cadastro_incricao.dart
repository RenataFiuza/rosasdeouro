import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'aluno.dart';
import 'oficina.dart';




class CadastroInscricao extends StatefulWidget {
  const CadastroInscricao({super.key});

  @override
  State<CadastroInscricao> createState() => _CadastroInscricaoState();
}

class _CadastroInscricaoState extends State<CadastroInscricao> {
  final TextEditingController dataCadastroController = TextEditingController();
  late List<Aluno> alunos;
  late List<Oficina> oficinas;
  Aluno? selectedAluno;
  Oficina? selectedOficina;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    final db = await DatabaseHelper().database;
    final alunoData = await db.query('aluno');
    final oficinaData = await db.query('oficina');

    setState(() {
      alunos = alunoData.map((data) => Aluno.fromMap(data)).toList();
      oficinas = oficinaData.map((data) => Oficina.fromMap(data)).toList();
    });
  }

  void salvarInscricao() async {
    if (selectedAluno != null && selectedOficina != null) {
      final db = await DatabaseHelper().database;
      await db.insert('cadastro', {
        'id_aluno': selectedAluno!.id,
        'id_oficina': selectedOficina!.id,
        'data_cadastro': dataCadastroController.text,
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Inscrição realizada!')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Selecione aluno e oficina!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar Inscrição')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<Aluno>(
              hint: const Text('Selecione o Aluno'),
              value: selectedAluno,
              onChanged: (Aluno? value) {
                setState(() {
                  selectedAluno = value;
                });
              },
              items: alunos
                  .map((aluno) => DropdownMenuItem(
                        value: aluno,
                        child: Text(aluno.nome),
                      ))
                  .toList(),
            ),
            DropdownButton<Oficina>(
              hint: const Text('Selecione a Oficina'),
              value: selectedOficina,
              onChanged: (Oficina? value) {
                setState(() {
                  selectedOficina = value;
                });
              },
              items: oficinas
                  .map((oficina) => DropdownMenuItem(
                        value: oficina,
                        child: Text(oficina.nomeOficina),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: dataCadastroController,
              decoration: const InputDecoration(labelText: 'Data da Inscrição'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: salvarInscricao, child: const Text('Salvar Inscrição')),
          ],
        ),
      ),
    );
  }
}
