import 'package:app_notas/datasources/models/aluno.dart';
import 'package:app_notas/datasources/models/base/base_model.dart';
import 'package:app_notas/datasources/models/disciplina.dart';
import 'package:app_notas/datasources/models/turma.dart';


class NotaAluno extends BaseModel<int?> {
  @override
  int? id;
  int? nota;
  int? bimestre;
  Aluno? aluno;
  Turma? turma;
  Disciplina? disciplina;
  static const Id = 'id';
  static const AlunoId = 'id_aluno';
  static const TurmaId = 'id_turma';
  static const Bimestre = 'bimestre';
  static const DisciplinaId = 'id_disciplina';
  static const Nota = 'nota';
  static const Tabela = 'TbNotaAluno';

  NotaAluno({
    this.id,
    this.nota,
    this.bimestre,
    this.aluno,
    this.turma,
    this.disciplina,
  });

  factory NotaAluno.fromMap(Map<dynamic, dynamic> json) {
    return NotaAluno(
      id: json[Id],
      nota: json[Nota],
      bimestre: json[Bimestre],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotaAluno &&
          runtimeType == other.runtimeType &&
          nota == other.nota &&
          bimestre == other.bimestre &&
          aluno == other.aluno &&
          turma == other.turma &&
          disciplina == other.disciplina;

  @override
  int get hashCode =>
      nota.hashCode ^
      bimestre.hashCode ^
      aluno.hashCode ^
      turma.hashCode ^
      disciplina.hashCode;

  Map<String, dynamic> toMap() {
    return {
      Id: id, // int
      AlunoId: aluno?.id,
      TurmaId: turma?.id,
      Bimestre: bimestre,
      DisciplinaId: disciplina?.id,
      Nota: nota, // float
    };
  }
}
