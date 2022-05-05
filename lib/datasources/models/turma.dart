const turmaId = 'id';
const turmaNome = 'nome';
const turmaTabela = 'TbTurma';

class Turma {
  int id;
  String nome;

  Turma({required this.id, required this.nome});

  factory Turma.fromMap(Map map) => Turma(
        id: map[turmaId],
        nome: map[turmaNome],
      );

  Map<String, dynamic> toMap() => {
        turmaId: id,
        turmaNome: nome,
      };
}
