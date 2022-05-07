import 'package:app_notas/datasources/local/base/base_helper.dart';
import 'package:app_notas/datasources/local/turma_helper.dart';
import 'package:app_notas/datasources/models/aluno.dart';
import 'package:app_notas/datasources/models/turma.dart';

class AlunoHelper extends BaseHelper<Aluno> {
  static const sqlCreate = '''
    CREATE TABLE ${Aluno.Tabela} (
      ${Aluno.Id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${Aluno.Nome} TEXT NOT NULL
    )
  ''';

  AlunoHelper() : super(Aluno.Id);

  @override
  convertFromMap(Map m) async => Aluno.fromMap(m);
}

class AlunoTurmaHelper extends BaseHelper<AlunoTurma> {
  static const sqlCreate = '''
    CREATE TABLE ${AlunoTurma.Tabela} (
      ${AlunoTurma.Id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${AlunoTurma.AlunoId} INTEGER NOT NULL,
      ${AlunoTurma.TurmaId} INTEGER NOT NULL,
      FOREIGN KEY(${AlunoTurma.AlunoId}) REFERENCES ${Aluno.Tabela}(${Aluno.Id}),
      FOREIGN KEY(${AlunoTurma.TurmaId}) REFERENCES ${Turma.Tabela}(${Turma.Id})
    )
  ''';

  AlunoTurmaHelper() : super(AlunoTurma.Id);

  @override
  convertFromMap(Map m) async {
    AlunoTurma alunoturma = AlunoTurma.fromMap(m);
    alunoturma.aluno = await AlunoHelper().getById(m[AlunoTurma.AlunoId]);
    alunoturma.turma = await TurmaHelper().getById(m[AlunoTurma.TurmaId]);
    return alunoturma;
  }
}
