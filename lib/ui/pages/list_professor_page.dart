import 'package:app_notas/datasources/local/professor_helper.dart';
import 'package:app_notas/datasources/local/base/base_helper.dart';
import 'package:app_notas/datasources/models/professor.dart';
import 'package:app_notas/datasources/models/base/base_model.dart';
import 'package:app_notas/ui/pages/base/base_list_page.dart';
import 'package:app_notas/ui/pages/base/base_cad_page.dart';
import 'package:app_notas/ui/pages/cad_professor_page.dart';

class ListProfessorPage extends BaseListPage {
  @override
  BaseListPageState<BaseListPage, BaseModel, BaseHelper<BaseModel>, BaseCadPage>
      createState() => ListProfessorPageState();
}

class ListProfessorPageState
    extends BaseListPageState<ListProfessorPage, Professor, ProfessorHelper, CadProfessorPage> {
  ListProfessorPageState() : super(ProfessorHelper(), 'Lista de Professores');

  @override
  String mostrarNome(Professor dado) => dado.nome;

  @override
  CadProfessorPage criarTelaCadastro(Professor? dado) =>
      CadProfessorPage(dado ?? Professor(nome: ""));
}
