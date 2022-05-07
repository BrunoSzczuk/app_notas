import 'package:app_notas/datasources/models/base/base_model.dart';

class Turma extends BaseModel<int?> {
  int? id;
  String nome;
  static const Id = 'id';
  static const Nome = 'nome';
  static const Tabela = 'TbTurma';

  Turma({this.id, required this.nome});

  factory Turma.fromMap(Map map) => Turma(
        id: map[Id],
        nome: map[Nome],
      );

  Map<String, dynamic> toMap() => {
        Id: id,
        Nome: nome,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Turma &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          nome == other.nome;

  @override
  int get hashCode => id.hashCode ^ nome.hashCode;
}
