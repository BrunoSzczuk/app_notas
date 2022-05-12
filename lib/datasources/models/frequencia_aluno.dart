import 'package:app_notas/datasources/models/aluno.dart';
import 'package:app_notas/datasources/models/base/base_model.dart';
import 'package:app_notas/datasources/models/disciplina.dart';
import 'package:app_notas/datasources/models/turma.dart';

class FrequenciaAluno extends BaseModel<int?> {
  static const Id = 'id';
  static const Data = 'data';
  static const AlunoId = 'id_aluno';
  static const TurmaId = 'id_turma';
  static const DisciplinaId = 'id_disciplina';
  static const Presente = 'presente';
  static const Tabela = 'TbFrequenciaAluno';
  @override
  int? id;
  bool? presente = false;
  Aluno? aluno;
  Turma? turma;
  String? data;
  Disciplina? disciplina;

  FrequenciaAluno({
    this.id,
    this.data,
    this.presente,
    this.aluno,
    this.turma,
    this.disciplina,
  });

  factory FrequenciaAluno.fromMap(Map<dynamic, dynamic> json) {
    return FrequenciaAluno(
      id: json[AlunoId],
      presente: json[Presente] == 1,
      data: json[Data],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FrequenciaAluno &&
          runtimeType == other.runtimeType &&
          aluno == other.aluno &&
          data == other.data &&
          disciplina == other.disciplina;

  @override
  int get hashCode => aluno.hashCode ^ data.hashCode ^ disciplina.hashCode;

  Map<String, dynamic> toMap() {
    return {
      Id: id, // int
      AlunoId: aluno?.id,
      TurmaId: turma?.id,
      DisciplinaId: disciplina?.id,
      Presente: presente, // bool
      Data: data, // date
    };
  }
}
