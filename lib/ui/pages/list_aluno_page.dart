import 'package:app_notas/datasources/local/aluno_helper.dart';
import 'package:app_notas/datasources/local/base/base_helper.dart';
import 'package:app_notas/datasources/models/aluno.dart';
import 'package:app_notas/datasources/models/base/base_model.dart';
import 'package:app_notas/ui/pages/base/base_list_page.dart';
import 'package:app_notas/ui/pages/base/base_cad_page.dart';
import 'package:app_notas/ui/pages/cad_aluno_page.dart';

class ListAlunoPage extends BaseListPage {
  @override
  BaseListPageState<BaseListPage, BaseModel, BaseHelper<BaseModel>, BaseCadPage>
      createState() => ListAlunoPageState();
}

class ListAlunoPageState
    extends BaseListPageState<ListAlunoPage, Aluno, AlunoHelper, CadAlunoPage> {
  ListAlunoPageState() : super(AlunoHelper(), 'Lista de Alunos');

  @override
  String textoDeExibicao(Aluno dado) => dado.nome;

  @override
  CadAlunoPage criarTelaCadastro(Aluno? dado) =>
      CadAlunoPage(dado ?? Aluno(nome: ""));
}
