import 'package:app_notas/datasources/local/base/base_helper.dart';
import 'package:app_notas/datasources/models/turma.dart';

class TurmaHelper extends BaseHelper<Turma> {
  static const sqlCreate = '''
    CREATE TABLE ${Turma.Tabela} (
      ${Turma.Id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${Turma.Nome} TEXT NOT NULL
    )
  ''';

  TurmaHelper() : super(Turma.Id);

  @override
  convertFromMap(Map m) async => Turma.fromMap(m);
}
