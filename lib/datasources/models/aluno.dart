import 'package:app_notas/datasources/models/base/base_model.dart';
import 'package:app_notas/datasources/models/turma.dart';

class Aluno extends BaseModel<int?> {
  static const Id = 'id';
  static const Nome = 'nome';
  static const Tabela = 'TbAluno';

  @override
  int? id;
  String nome;

  Aluno({this.id, required this.nome});

  factory Aluno.fromMap(Map map) => Aluno(
        id: map[Id],
        nome: map[Nome],
      );

  @override
  Map<String, dynamic> toMap() => {
        Id: id,
        Nome: nome,
      };
}

class AlunoTurma extends BaseModel<int?> {
  static const Id = 'id';
  static const AlunoId = 'id_aluno';
  static const TurmaId = 'id_turma';
  static const Tabela = 'TbAlunoTurma';
  @override
  int? id;
  Aluno aluno;
  Turma turma;


  AlunoTurma({this.id, required this.aluno, required this.turma});

  @override
  Map<String, dynamic> toMap() => {
        Id: id,
        AlunoId: aluno.toMap(),
        TurmaId: turma.toMap(),
      };

  factory AlunoTurma.fromMap(Map map) => AlunoTurma(
        id: map[Id],
        aluno: Aluno.fromMap(map[AlunoId]),
        turma: Turma.fromMap(map[TurmaId]),
      );
}
