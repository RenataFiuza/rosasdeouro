import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'aluno.dart';

class CadastroAluno extends StatefulWidget {
  const CadastroAluno({super.key});

  @override
  State<CadastroAluno> createState() => _CadastroAlunoState();
}

class _CadastroAlunoState extends State<CadastroAluno> {
  final nomeController = TextEditingController();
  final enderecoController = TextEditingController();
  final telefoneController = TextEditingController();

  void salvarAluno() async {
    final aluno = Aluno(nome: nomeController.text, endereco: enderecoController.text, telefone: telefoneController.text);
    final db = await DatabaseHelper().database;
    await db.insert('aluno', aluno.toMap());
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Aluno cadastrado!')));
    nomeController.clear();
    enderecoController.clear();
    telefoneController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar Aluno')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          TextField(controller: nomeController, decoration: const InputDecoration(labelText: 'Nome')),
          TextField(controller: enderecoController, decoration: const InputDecoration(labelText: 'Endereço')),
          TextField(controller: telefoneController, decoration: const InputDecoration(labelText: 'Telefone')),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: salvarAluno, child: const Text('Salvar')),
        ]),
      ),
    );
  }
}
