import 'package:app_notas/datasources/local/banco_dados.dart';
import 'package:app_notas/datasources/local/base/base_helper.dart';
import 'package:app_notas/datasources/local/turma_helper.dart';
import 'package:app_notas/datasources/models/aluno.dart';
import 'package:app_notas/datasources/models/disciplina.dart';
import 'package:app_notas/datasources/models/nota_aluno.dart';
import 'package:app_notas/datasources/models/turma.dart';
import 'package:sqflite/sqflite.dart';

import 'aluno_helper.dart';
import 'disciplina_helper.dart';

class NotaAlunoHelper extends BaseHelper<NotaAluno> {
  static const sqlCreate = '''
    CREATE TABLE ${NotaAluno.Tabela} (
      ${NotaAluno.Id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${NotaAluno.TurmaId} INTEGER NOT NULL,
      ${NotaAluno.AlunoId} INTEGER NOT NULL,
      ${NotaAluno.DisciplinaId} INTEGER NOT NULL,
      ${NotaAluno.Nota} int NOT NULL,
      ${NotaAluno.Bimestre} int NOT NULL,
      
      FOREIGN KEY(${NotaAluno.TurmaId}) REFERENCES ${Turma.Tabela}(${Turma.Id}),
      FOREIGN KEY(${NotaAluno.DisciplinaId}) REFERENCES ${Disciplina.Tabela}(${Disciplina.Id}),
      FOREIGN KEY(${NotaAluno.AlunoId}) REFERENCES ${Aluno.Tabela}(${Aluno.Id})
    )
  ''';

  NotaAlunoHelper() : super(NotaAluno.Id);

  @override
  convertFromMap(Map m) async {
    NotaAluno notaAluno = NotaAluno.fromMap(m);
    notaAluno.turma = await TurmaHelper().getById(m[NotaAluno.TurmaId]);
    notaAluno.aluno = await AlunoHelper().getById(m[NotaAluno.AlunoId]);
    notaAluno.disciplina =
        await DisciplinaHelper().getById(m[NotaAluno.DisciplinaId]);
    return notaAluno;
  }

  getByTurmaDisciplinaAndBimestreAndAluno(
      Turma turma, Disciplina disciplina, int bimestre, Aluno aluno) async {
    Database db = await BancoDados().db;
    List<Map> maps = await db.query(
      NotaAluno.Tabela,
      where:
          '${NotaAluno.TurmaId} = ? AND ${NotaAluno.DisciplinaId} = ? AND ${NotaAluno.Bimestre} = ? AND ${NotaAluno.AlunoId} = ?',
      whereArgs: [turma.id, disciplina.id, bimestre, aluno.id],
    );
    DisciplinaHelper disciplinaHelper = DisciplinaHelper();
    AlunoHelper alunoHelper = AlunoHelper();
    TurmaHelper turmaHelper = TurmaHelper();
    List<NotaAluno> retorno = [];
    for (Map m in maps) {
      NotaAluno notaAluno = NotaAluno.fromMap(m);
      notaAluno.turma = await turmaHelper.getById(m[NotaAluno.TurmaId]);
      notaAluno.aluno = await alunoHelper.getById(m[NotaAluno.AlunoId]);
      notaAluno.disciplina =
          await disciplinaHelper.getById(m[NotaAluno.DisciplinaId]);
      retorno.add(notaAluno);
    }
    return retorno;
  }
}
