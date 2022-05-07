import 'package:app_notas/datasources/models/base/base_model.dart';

const professorId = 'id';
const professorNome = 'nome';
const professorTabela = 'TbProfessor';

class Professor extends BaseModel<int?> {
  static const Id = 'id';
  static const Nome = 'nome';
  static const Tabela = 'TbProfessor';

  int? id;
  String nome;

  Professor({this.id, required this.nome});

  factory Professor.fromMap(Map map) => Professor(
        id: map[professorId],
        nome: map[professorNome],
      );

  Map<String, dynamic> toMap() => {
        professorId: id,
        professorNome: nome,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Professor &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          nome == other.nome;

  @override
  int get hashCode => id.hashCode ^ nome.hashCode;
}
