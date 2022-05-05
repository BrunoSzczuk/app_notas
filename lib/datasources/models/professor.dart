const professorId = 'id';
const professorNome = 'nome';
const professorTabela = 'TbProfessor';

class Professor {
  int id;
  String nome;

  Professor({required this.id, required this.nome});

  factory Professor.fromMap(Map map) => Professor(
        id: map[professorId],
        nome: map[professorNome],
      );

  Map<String, dynamic> toMap() => {
        professorId: id,
        professorNome: nome,
      };
}
