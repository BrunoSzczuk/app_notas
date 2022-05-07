import 'package:app_notas/datasources/local/base/base_helper.dart';
import 'package:app_notas/datasources/models/professor.dart';

class ProfessorHelper extends BaseHelper<Professor> {
  static const sqlCreate = '''
    CREATE TABLE ${Professor.Tabela} (
      ${Professor.Id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${Professor.Nome} TEXT NOT NULL
    )
  ''';

  ProfessorHelper() : super(Professor.Id);

  @override
  convertFromMap(Map m) async => Professor.fromMap(m);
}
