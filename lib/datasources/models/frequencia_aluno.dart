
import 'package:app_notas/datasources/models/aluno.dart';
import 'package:app_notas/datasources/models/disciplina.dart';
import 'package:app_notas/datasources/models/turma.dart';

const frequenciaAlunoId = 'id';
const frequenciaAlunoData = 'data';
const frequenciaAlunoAlunoId = 'id_aluno';
const frequenciaAlunoTurmaId = 'id_turma';
const frequenciaAlunoDisciplinaId = 'id_disciplina';
const frequenciaAlunoFrequencia = 'frequencia';

class FrequenciaAluno {
  int id;
  bool presente = false;
  Aluno aluno;
  Turma turma;
  DateTime data;
  Disciplina disciplina;

  FrequenciaAluno({
    required this.id,
    required this.data,
    required this.presente,
    required this.aluno,
    required this.turma,
    required this.disciplina,
  });

  factory FrequenciaAluno.fromMap(Map<String, dynamic> json) {
    return FrequenciaAluno(
      id: json[frequenciaAlunoId],
      presente: json[frequenciaAlunoFrequencia],
      aluno: Aluno.fromMap(json[frequenciaAlunoAlunoId]),
      turma: Turma.fromMap(json[frequenciaAlunoTurmaId]),
      disciplina: Disciplina.fromMap(json[frequenciaAlunoDisciplinaId]),
      data: DateTime.parse(json[frequenciaAlunoData]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      frequenciaAlunoId: id, // int
      frequenciaAlunoAlunoId: aluno.toMap(),
      frequenciaAlunoTurmaId: turma.toMap(),
      frequenciaAlunoDisciplinaId: disciplina.toMap(),
      frequenciaAlunoFrequencia: presente, // float
      frequenciaAlunoData: data.toString(), // string
    };
  }
}
