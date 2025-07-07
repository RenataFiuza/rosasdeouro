import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'oficina.dart';

class CadastroOficina extends StatefulWidget {
  const CadastroOficina({super.key});

  @override
  State<CadastroOficina> createState() => _CadastroOficinaState();
}

class _CadastroOficinaState extends State<CadastroOficina> {
  final nomeOficinaController = TextEditingController();
  final vagasController = TextEditingController();

  void salvarOficina() async {
    final oficina = Oficina(
      nomeOficina: nomeOficinaController.text,
      vagasDisponiveis: int.parse(vagasController.text),
    );
    final db = await DatabaseHelper().database;
    await db.insert('oficina', oficina.toMap());
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Oficina cadastrada!')));
    nomeOficinaController.clear();
    vagasController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar Oficina')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nomeOficinaController,
              decoration: const InputDecoration(labelText: 'Nome da Oficina'),
            ),
            TextField(
              controller: vagasController,
              decoration: const InputDecoration(labelText: 'Vagas Disponíveis'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: salvarOficina, child: const Text('Salvar')),
          ],
        ),
      ),
    );
  }
}
