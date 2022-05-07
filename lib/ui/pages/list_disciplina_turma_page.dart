
import 'package:app_notas/datasources/local/disciplina_helper.dart';
import 'package:app_notas/datasources/local/base/base_helper.dart';
import 'package:app_notas/datasources/models/disciplina.dart';
import 'package:app_notas/datasources/models/base/base_model.dart';
import 'package:app_notas/ui/pages/base/base_list_page.dart';
import 'package:app_notas/ui/pages/base/base_cad_page.dart';
import 'package:app_notas/ui/pages/cad_disciplina_turma_page.dart';

class ListDisciplinaTurmaPage extends BaseListPage {
  @override
  BaseListPageState<BaseListPage, BaseModel, BaseHelper<BaseModel>, BaseCadPage>
      createState() => ListDisciplinaTurmaPageState();
}

class ListDisciplinaTurmaPageState
    extends BaseListPageState<ListDisciplinaTurmaPage, DisciplinaTurma, DisciplinaTurmaHelper, CadDisciplinaTurmaPage> {
  ListDisciplinaTurmaPageState() : super(DisciplinaTurmaHelper(), 'Lista de Disciplina x Turmas');

  @override
  String textoDeExibicao(DisciplinaTurma dado) => dado.disciplina!.nome! + ' - ' + dado.turma!.nome;

  @override
  CadDisciplinaTurmaPage criarTelaCadastro(DisciplinaTurma? dado) =>
      CadDisciplinaTurmaPage(dado ?? DisciplinaTurma());
}
