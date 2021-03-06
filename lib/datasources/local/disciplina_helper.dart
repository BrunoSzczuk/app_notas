import 'package:app_notas/datasources/local/base/base_helper.dart';
import 'package:app_notas/datasources/local/professor_helper.dart';
import 'package:app_notas/datasources/local/turma_helper.dart';
import 'package:app_notas/datasources/models/disciplina.dart';
import 'package:app_notas/datasources/models/professor.dart';
import 'package:app_notas/datasources/models/turma.dart';

class DisciplinaHelper extends BaseHelper<Disciplina> {
  static const sqlCreate = '''
    CREATE TABLE ${Disciplina.Tabela} (
      ${Disciplina.Id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${Disciplina.Nome} TEXT NOT NULL,
      ${Disciplina.ProfessorId} INTEGER NOT NULL,
       FOREIGN KEY(${Disciplina.ProfessorId}) REFERENCES ${Professor.Tabela}(${Professor.Id})
    )
  ''';

  DisciplinaHelper() : super(Disciplina.Id);

  @override
  convertFromMap(Map m) async {
    Disciplina disciplina = Disciplina.fromMap(m);
    Professor? professor =
        await ProfessorHelper().getById(m[Disciplina.ProfessorId]);
    disciplina.professor = professor;
    return disciplina;
  }
}

class DisciplinaTurmaHelper extends BaseHelper<DisciplinaTurma> {
  DisciplinaTurmaHelper() : super(DisciplinaTurma.Id);
  static const sqlCreate = '''
    CREATE TABLE ${DisciplinaTurma.Tabela} (
      ${DisciplinaTurma.Id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${DisciplinaTurma.DisciplinaId} INTEGER NOT NULL,
      ${DisciplinaTurma.TurmaId} INTEGER NOT NULL,
      FOREIGN KEY(${DisciplinaTurma.DisciplinaId}) REFERENCES ${Disciplina.Tabela}(${Disciplina.Id}),
      FOREIGN KEY(${DisciplinaTurma.TurmaId}) REFERENCES ${Turma.Tabela}(${Turma.Id})
    )
  ''';

  @override
  convertFromMap(Map m) async {
    DisciplinaTurma disciplinaTurma = DisciplinaTurma.fromMap(m);
    disciplinaTurma.turma =
        await TurmaHelper().getById(m[DisciplinaTurma.TurmaId]);
    disciplinaTurma.disciplina =
        await DisciplinaHelper().getById(m[DisciplinaTurma.DisciplinaId]);
    return disciplinaTurma;
  }
}
