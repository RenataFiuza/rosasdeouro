
import 'cadastro_aluno.dart';
import 'cadastro_oficina.dart';
import 'cadastro_inscricao.dart';

import 'package:flutter/material.dart';
import 'lista_geral.dart';
import 'database_helper.dart';
import 'quote_service.dart';

void main() {
  runApp(const RosasDeOuroApp());
}

class RosasDeOuroApp extends StatelessWidget {
  const RosasDeOuroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rosas de Ouro',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/cadastro-aluno': (_) => const CadastroAluno(),
        '/cadastro-oficina': (_) => const CadastroOficina(),
        '/cadastro-inscricao': (_) => const CadastroInscricao(),
        '/lista-geral': (_) => const ListaGeral(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final QuoteService _quoteService = QuoteService();
  Quote? _quote;

  @override
  void initState() {
    super.initState();
    _loadQuote();
  }

  void _loadQuote() async {
    final quote = await _quoteService.fetchRandomQuote();
    setState(() {
      _quote = quote;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rosas de Ouro – Sistema de Oficinas')),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(child: Text('Menu', style: TextStyle(fontSize: 24))),
            ListTile(
              title: const Text('Cadastrar Aluno'),
              onTap: () => Navigator.pushNamed(context, '/cadastro-aluno'),
            ),
            ListTile(
              title: const Text('Cadastrar Oficina'),
              onTap: () => Navigator.pushNamed(context, '/cadastro-oficina'),
            ),
            ListTile(
              title: const Text('Fazer Inscrição'),
              onTap: () => Navigator.pushNamed(context, '/cadastro-inscricao'),
            ),
            ListTile(
              title: const Text('Listagem Geral'),
              onTap: () => Navigator.pushNamed(context, '/lista-geral'),
            ),
          ],
        ),
      ),
      body: Center(
        child: _quote == null
            ? const CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Bem-vindo ao Rosas de Ouro!\n', style: TextStyle(fontSize: 20)),
                    Text(
                      '"${_quote!.content}"',
                      style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "- ${_quote!.author}",
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
