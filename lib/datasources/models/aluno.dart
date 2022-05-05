import 'package:app_notas/datasources/models/turma.dart';

const alunoId = 'id';
const alunoNome = 'nome';
const alunoTurma = 'turma_id';
const alunoTabela = 'TbAluno';

class Aluno {
  int id;
  String nome;
  Turma? turma;

  Aluno({required this.id, required this.nome, this.turma});

  factory Aluno.fromMap(Map map) => Aluno(
        id: map[alunoId],
        nome: map[alunoNome],
        turma: map[alunoTurma] != null ? Turma.fromMap(map[alunoTurma]) : null,
      );

  Map<String, dynamic> toMap() => {
        alunoId: id,
        alunoNome: nome,
        alunoTurma: turma,
      };
}

const alunoTurmaId = 'id';
const alunoTurmaAlunoId = 'id_aluno';
const alunoTurmaTurmaId = 'id_turma';

class AlunoTurma {
  int id;
  Aluno aluno;
  Turma turma;

  AlunoTurma({required this.id, required this.aluno, required this.turma});

  Map<String, dynamic> toMap() => {
        alunoTurmaId: id,
        alunoTurmaAlunoId: aluno.toMap(),
        alunoTurmaTurmaId: turma.toMap(),
      };

  factory AlunoTurma.fromMap(Map map) => AlunoTurma(
        id: map[alunoTurmaId],
        aluno: Aluno.fromMap(map[alunoTurmaAlunoId]),
        turma: Turma.fromMap(map[alunoTurmaTurmaId]),
      );
}
