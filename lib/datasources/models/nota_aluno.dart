import 'dart:ffi';

import 'package:app_notas/datasources/models/aluno.dart';
import 'package:app_notas/datasources/models/disciplina.dart';
import 'package:app_notas/datasources/models/turma.dart';

const notaAlunoId = 'id';
const notaAlunoAlunoId = 'id_aluno';
const notaAlunoTurmaId = 'id_turma';
const notaAlunoDisciplinaId = 'id_disciplina';
const notaAlunoNota = 'nota';

class NotaAluno {
  int id;
  Float? nota;
  Aluno aluno;
  Turma turma;
  Disciplina disciplina;

  NotaAluno({
    required this.id,
    required this.nota,
    required this.aluno,
    required this.turma,
    required this.disciplina,
  });

  factory NotaAluno.fromMap(Map<String, dynamic> json) {
    return NotaAluno(
      id: json[notaAlunoId],
      nota: json[notaAlunoNota],
      aluno: Aluno.fromMap(json[notaAlunoAlunoId]),
      turma: Turma.fromMap(json[notaAlunoTurmaId]),
      disciplina: Disciplina.fromMap(json[notaAlunoDisciplinaId]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      notaAlunoId: id, // int
      notaAlunoAlunoId: aluno.toMap(),
      notaAlunoTurmaId: turma.toMap(),
      notaAlunoDisciplinaId: disciplina.toMap(),
      notaAlunoNota: nota, // float
    };
  }
}
