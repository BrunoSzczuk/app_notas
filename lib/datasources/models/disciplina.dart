import 'package:app_notas/datasources/models/base/base_model.dart';
import 'package:app_notas/datasources/models/professor.dart';
import 'package:app_notas/datasources/models/turma.dart';

class Disciplina extends BaseModel<int?> {
  int? id;
  String nome;
  Professor professor;
  static const Id = 'id';
  static const Nome = 'nome';
  static const ProfessorId = 'professor_id';
  static const Tabela = 'TbDisciplina';

  Disciplina({this.id, required this.nome, required this.professor});

  factory Disciplina.fromMap(Map map) => Disciplina(
        id: map[Id],
        nome: map[Nome],
        professor: Professor.fromMap(map[ProfessorId]),
      );

  Map<String, dynamic> toMap() => {
        Id: id,
        Nome: nome,

      };
}

class DisciplinaTurma extends BaseModel<int?> {
  int? id;
  Disciplina disciplina;
  Turma turma;

  static const Id = 'id';
  static const DisciplinaId = 'id_disciplina';
  static const TurmaId = 'id_turma';
  static const Tabela = 'TbDisciplinaTurma';

  DisciplinaTurma({this.id, required this.disciplina, required this.turma});

  Map<String, dynamic> toMap() => {
        TurmaId: id,
        DisciplinaId: disciplina.toMap(),
        TurmaId: turma.toMap(),
      };

  factory DisciplinaTurma.fromMap(Map map) => DisciplinaTurma(
        id: map[TurmaId],
        disciplina: Disciplina.fromMap(map[DisciplinaId]),
        turma: Turma.fromMap(map[TurmaId]),
      );
}
