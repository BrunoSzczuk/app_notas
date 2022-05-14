import 'package:app_notas/datasources/models/base/base_model.dart';
import 'package:app_notas/datasources/models/professor.dart';
import 'package:app_notas/datasources/models/turma.dart';

class Disciplina extends BaseModel<int?> {
  @override
  int? id;
  String? nome;
  Professor? professor;
  static const Id = 'id';
  static const Nome = 'nome';
  static const ProfessorId = 'professor_id';
  static const Tabela = 'TbDisciplina';

  Disciplina({this.id,  this.nome,  this.professor});

  factory Disciplina.fromMap(Map map) => Disciplina(
      id: map[Id],
      nome: map[Nome]
  );

  Map<String, dynamic> toMap() => {
    Id: id,
    Nome: nome,
    ProfessorId: professor?.id,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Disciplina &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              nome == other.nome &&
              professor == other.professor;

  @override
  int get hashCode => id.hashCode ^ nome.hashCode ^ professor.hashCode;
}

class DisciplinaTurma extends BaseModel<int?> {
  int? id;
  Disciplina? disciplina;
  Turma? turma;

  static const Id = 'id';
  static const DisciplinaId = 'id_disciplina';
  static const TurmaId = 'id_turma';
  static const Tabela = 'TbDisciplinaTurma';

  DisciplinaTurma({this.id, this.disciplina, this.turma});

  Map<String, dynamic> toMap() => {
        Id: id,
        DisciplinaId: disciplina?.id,
        TurmaId: turma?.id,
      };

  factory DisciplinaTurma.fromMap(Map map) => DisciplinaTurma(
        id: map[TurmaId],
      );
}
