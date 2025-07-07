import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'rosas_de_ouro.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Criação da tabela 'aluno'
        await db.execute('''
          CREATE TABLE aluno (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT,
            endereco TEXT,
            telefone TEXT
          )
        ''');

        // Criação da tabela 'oficina'
        await db.execute('''
          CREATE TABLE oficina (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome_oficina TEXT,
            vagas_disponiveis INTEGER
          )
        ''');

        // Criação da tabela 'cadastro'
        await db.execute('''
          CREATE TABLE cadastro (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            id_aluno INTEGER,
            id_oficina INTEGER,
            data_cadastro TEXT,
            FOREIGN KEY(id_aluno) REFERENCES aluno(id),
            FOREIGN KEY(id_oficina) REFERENCES oficina(id)
          )
        ''');
      },
    );
  }
}
