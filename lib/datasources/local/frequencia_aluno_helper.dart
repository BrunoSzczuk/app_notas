import 'package:app_notas/datasources/local/banco_dados.dart';
import 'package:app_notas/datasources/local/base/base_helper.dart';
import 'package:app_notas/datasources/local/turma_helper.dart';
import 'package:app_notas/datasources/models/aluno.dart';
import 'package:app_notas/datasources/models/disciplina.dart';
import 'package:app_notas/datasources/models/frequencia_aluno.dart';
import 'package:app_notas/datasources/models/turma.dart';
import 'package:sqflite/sqflite.dart';

import 'aluno_helper.dart';
import 'disciplina_helper.dart';

class FrequenciaAlunoHelper extends BaseHelper<FrequenciaAluno> {
  static const sqlCreate = '''
    CREATE TABLE ${FrequenciaAluno.Tabela} (
      ${FrequenciaAluno.Id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${FrequenciaAluno.TurmaId} INTEGER NOT NULL,
      ${FrequenciaAluno.AlunoId} INTEGER NOT NULL,
      ${FrequenciaAluno.DisciplinaId} INTEGER NOT NULL,
      ${FrequenciaAluno.Data} date NOT NULL,
      ${FrequenciaAluno.Presente} boolean NOT NULL,
      FOREIGN KEY(${FrequenciaAluno.TurmaId}) REFERENCES ${Turma.Tabela}(${Turma.Id}),
      FOREIGN KEY(${FrequenciaAluno.DisciplinaId}) REFERENCES ${Disciplina.Tabela}(${Disciplina.Id}),
      FOREIGN KEY(${FrequenciaAluno.AlunoId}) REFERENCES ${Aluno.Tabela}(${Aluno.Id})
    )
  ''';

  FrequenciaAlunoHelper() : super(FrequenciaAluno.Id);

  @override
  convertFromMap(Map m) async {
    FrequenciaAluno frequenciaAluno = FrequenciaAluno.fromMap(m);
    frequenciaAluno.turma =
        await TurmaHelper().getById(m[FrequenciaAluno.TurmaId]);
    frequenciaAluno.aluno =
        await AlunoHelper().getById(m[FrequenciaAluno.AlunoId]);
    frequenciaAluno.disciplina =
        await DisciplinaHelper().getById(m[FrequenciaAluno.DisciplinaId]);
    return frequenciaAluno;
  }

  getByTurmaDisciplinaAndDateAndAluno(
      Turma turma, Disciplina disciplina, DateTime? data, Aluno aluno) async {
    Database db = await BancoDados().db;
    List<Map> maps = await db.query(
      FrequenciaAluno.Tabela,
      where:
          '${FrequenciaAluno.TurmaId} = ? AND ${FrequenciaAluno.DisciplinaId} = ? AND ${FrequenciaAluno.Data} = ? AND ${FrequenciaAluno.AlunoId} = ?',
      whereArgs: [turma.id, disciplina.id, data.toString(), aluno.id],
    );
    DisciplinaHelper disciplinaHelper = DisciplinaHelper();
    AlunoHelper alunoHelper = AlunoHelper();
    TurmaHelper turmaHelper = TurmaHelper();
    List<FrequenciaAluno> retorno = [];
    for (Map m in maps) {
      FrequenciaAluno frequenciaAluno = FrequenciaAluno.fromMap(m);
      frequenciaAluno.turma =
          await turmaHelper.getById(m[FrequenciaAluno.TurmaId]);
      frequenciaAluno.aluno =
          await alunoHelper.getById(m[FrequenciaAluno.AlunoId]);
      frequenciaAluno.disciplina =
          await disciplinaHelper.getById(m[FrequenciaAluno.DisciplinaId]);
      retorno.add(frequenciaAluno);
    }
    return retorno;
  }

  Future<int> getByTurmaDisciplinaAlunoPresentes(
      Turma turma, Disciplina disciplina, Aluno aluno) async {
    Database db = await BancoDados().db;

    List<Map> maps = await db.rawQuery(
        'SELECT count(*) as count FROM ${FrequenciaAluno.Tabela} WHERE ${FrequenciaAluno.Presente} AND ${FrequenciaAluno.TurmaId} = ? AND ${FrequenciaAluno.DisciplinaId} = ? AND ${FrequenciaAluno.AlunoId} = ? ',
        [turma.id, disciplina.id, aluno.id]);

    return maps[0]['count'];
  }

  Future<int> getByTurmaDisciplina(Turma turma, Disciplina disciplina) async {
    Database db = await BancoDados().db;
    List<Map> maps = await db.rawQuery(
        'SELECT count(*) as count FROM ${FrequenciaAluno.Tabela} WHERE ${FrequenciaAluno.TurmaId} = ? AND ${FrequenciaAluno.DisciplinaId} = ? group by ${FrequenciaAluno.AlunoId}',
        [turma.id, disciplina.id]);

    return maps[0]['count'];
  }
}
