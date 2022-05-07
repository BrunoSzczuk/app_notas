import 'package:app_notas/datasources/local/turma_helper.dart';
import 'package:app_notas/datasources/local/base/base_helper.dart';
import 'package:app_notas/datasources/models/turma.dart';
import 'package:app_notas/datasources/models/base/base_model.dart';
import 'package:app_notas/ui/pages/base/base_list_page.dart';
import 'package:app_notas/ui/pages/base/base_cad_page.dart';
import 'package:app_notas/ui/pages/cad_turma_page.dart';

class ListTurmaPage extends BaseListPage {
  @override
  BaseListPageState<BaseListPage, BaseModel, BaseHelper<BaseModel>, BaseCadPage>
      createState() => ListTurmaPageState();
}

class ListTurmaPageState
    extends BaseListPageState<ListTurmaPage, Turma, TurmaHelper, CadTurmaPage> {
  ListTurmaPageState() : super(TurmaHelper(), 'Lista de Turmas');

  @override
  String textoDeExibicao(Turma dado) => dado.nome;

  @override
  CadTurmaPage criarTelaCadastro(Turma? dado) =>
      CadTurmaPage(dado ?? Turma(nome: ""));
}
