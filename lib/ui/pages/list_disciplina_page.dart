import 'package:app_notas/datasources/local/disciplina_helper.dart';
import 'package:app_notas/datasources/local/base/base_helper.dart';
import 'package:app_notas/datasources/models/disciplina.dart';
import 'package:app_notas/datasources/models/base/base_model.dart';
import 'package:app_notas/ui/pages/base/base_list_page.dart';
import 'package:app_notas/ui/pages/base/base_cad_page.dart';
import 'package:app_notas/ui/pages/cad_disciplina_page.dart';

class ListDisciplinaPage extends BaseListPage {
  @override
  BaseListPageState<BaseListPage, BaseModel, BaseHelper<BaseModel>, BaseCadPage>
      createState() => ListDisciplinaPageState();
}

class ListDisciplinaPageState extends BaseListPageState<ListDisciplinaPage,
    Disciplina, DisciplinaHelper, CadDisciplinaPage> {
  ListDisciplinaPageState() : super(DisciplinaHelper(), 'Lista de Disciplinas');

  @override
  String textoDeExibicao(Disciplina dado) => dado.nome ?? '';

  @override
  CadDisciplinaPage criarTelaCadastro(Disciplina? dado) =>
      CadDisciplinaPage(dado ?? Disciplina());
}
