import 'package:app_notas/datasources/local/aluno_helper.dart';
import 'package:app_notas/datasources/local/disciplina_helper.dart';
import 'package:app_notas/datasources/local/professor_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BancoDados {
  static const String _nomeBanco = 'app_notas.db';

  static final BancoDados _intancia = BancoDados.internal();

  factory BancoDados() => _intancia;

  BancoDados.internal();

  Database? _db;

  Future<Database> get db async {
    _db ??= await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    final path = await getDatabasesPath();
    final pathDb = join(path, _nomeBanco);

    return await openDatabase(pathDb, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(AlunoHelper.sqlCreate);
      await db.execute(AlunoTurmaHelper.sqlCreate);
      await db.execute(ProfessorHelper.sqlCreate);
      await db.execute(DisciplinaHelper.sqlCreate);
      await db.execute(DisciplinaTurmaHelper.sqlCreate);
    });
  }

  void close() async {
    Database meuDb = await db;
    meuDb.close();
  }
}