import 'package:app_notas/datasources/models/turma.dart';

const disciplinaId = 'id';
const disciplinaNome = 'nome';
const disciplinaTabela = 'TbDisciplina';

class Disciplina {
  int id;
  String nome;

  Disciplina({required this.id, required this.nome});

  factory Disciplina.fromMap(Map map) => Disciplina(
        id: map[disciplinaId],
        nome: map[disciplinaNome],
      );

  Map<String, dynamic> toMap() => {
        disciplinaId: id,
        disciplinaNome: nome,
      };
}

const disciplinaTurmaId = 'id';
const disciplinaTurmaDisciplinaId = 'id_disciplina';
const disciplinaTurmaTurmaId = 'id_turma';

class DisciplinaTurma {
  int id;
  Disciplina disciplina;
  Turma turma;

  DisciplinaTurma(
      {required this.id, required this.disciplina, required this.turma});

  Map<String, dynamic> toMap() => {
        disciplinaTurmaId: id,
        disciplinaTurmaDisciplinaId: disciplina.toMap(),
        disciplinaTurmaTurmaId: turma.toMap(),
      };

  factory DisciplinaTurma.fromMap(Map map) => DisciplinaTurma(
        id: map[disciplinaTurmaId],
        disciplina: Disciplina.fromMap(map[disciplinaTurmaDisciplinaId]),
        turma: Turma.fromMap(map[disciplinaTurmaTurmaId]),
      );
}
