
import 'package:app_notas/datasources/local/aluno_helper.dart';
import 'package:app_notas/datasources/local/base/base_helper.dart';
import 'package:app_notas/datasources/models/aluno.dart';
import 'package:app_notas/datasources/models/base/base_model.dart';
import 'package:app_notas/ui/pages/base/base_list_page.dart';
import 'package:app_notas/ui/pages/base/base_cad_page.dart';
import 'package:app_notas/ui/pages/cad_aluno_turma_page.dart';

class ListAlunoTurmaPage extends BaseListPage {
  @override
  BaseListPageState<BaseListPage, BaseModel, BaseHelper<BaseModel>, BaseCadPage>
      createState() => ListAlunoTurmaPageState();
}

class ListAlunoTurmaPageState
    extends BaseListPageState<ListAlunoTurmaPage, AlunoTurma, AlunoTurmaHelper, CadAlunoTurmaPage> {
  ListAlunoTurmaPageState() : super(AlunoTurmaHelper(), 'Lista de Aluno x Turmas');

  @override
  String textoDeExibicao(AlunoTurma dado) => dado.aluno!.nome + ' - ' + dado.turma!.nome;

  @override
  CadAlunoTurmaPage criarTelaCadastro(AlunoTurma? dado) =>
      CadAlunoTurmaPage(dado ?? AlunoTurma());
}
