import 'package:app_notas/datasources/local/aluno_helper.dart';
import 'package:app_notas/datasources/local/base/base_helper.dart';
import 'package:app_notas/datasources/local/disciplina_helper.dart';
import 'package:app_notas/datasources/local/frequencia_aluno_helper.dart';
import 'package:app_notas/datasources/local/nota_aluno_helper.dart';
import 'package:app_notas/datasources/local/turma_helper.dart';
import 'package:app_notas/datasources/models/aluno.dart';
import 'package:app_notas/datasources/models/base/base_model.dart';
import 'package:app_notas/datasources/models/disciplina.dart';
import 'package:app_notas/datasources/models/turma.dart';
import 'package:app_notas/ui/pages/base/base_cad_page.dart';
import 'package:app_notas/ui/pages/base/base_list_page.dart';
import 'package:app_notas/ui/pages/cad_nota_aluno_page.dart';
import 'package:flutter/material.dart';

class ListResultadoPage extends BaseListPage {
  @override
  BaseListPageState<BaseListPage, BaseModel, BaseHelper<BaseModel>,
      BaseCadPage<BaseModel>> createState() => ListResultadoState();
}

class ListResultadoState extends BaseListPageState<ListResultadoPage,
    AlunoTurma, AlunoTurmaHelper, CadNotaAlunoPage> {
  ListResultadoState()
      : super(
          AlunoTurmaHelper(),
          'Resultado Final',
        );
  final turmaHelper = TurmaHelper();
  final disciplinaHelper = DisciplinaHelper();
  final alunoHelper = AlunoHelper();
  final notaAlunoHelper = NotaAlunoHelper();
  final frequenciaHelper = FrequenciaAlunoHelper();
  Turma? turma;
  Disciplina? disciplina;

  @override
  floatingButtonEnabled() => false;

  @override
  slideEnabled() => false;

  @override
  tapEnabled() => false;

  bool isCamposValidos() => disciplina != null && turma != null;

  @override
  List<Widget> widgets() {
    return [
      const Text('Turma'),
      FutureBuilder<List<Turma>>(
          future: turmaHelper.getAll(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return DropdownButton<Turma>(
                  hint: const Text('Selecione uma Turma'),
                  isExpanded: true,
                  value: turma,
                  onChanged: (value) {
                    setState(() {
                      turma = value;
                    });
                  },
                  items: snapshot.data?.map((turma) {
                    return DropdownMenuItem<Turma>(
                      value: turma,
                      child: Text(turma.nome),
                    );
                  }).toList());
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      const Text('Disciplina'),
      FutureBuilder<List<Disciplina>>(
        future: disciplinaHelper.getAll(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return DropdownButton<Disciplina>(
                hint: const Text('Selecione uma Disciplina'),
                isExpanded: true,
                value: disciplina,
                onChanged: (value) {
                  setState(() {
                    disciplina = value;
                  });
                },
                items: snapshot.data?.map((disciplina) {
                  return DropdownMenuItem<Disciplina>(
                    value: disciplina,
                    child: Text(disciplina.nome!),
                  );
                }).toList());
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      ElevatedButton(
          onPressed: _buscar,
          child: const Text('Buscar'),
          style: ElevatedButton.styleFrom(primary: Colors.green)),
    ];
  }

  @override
  Future<List<AlunoTurma>> buscaDadosParaLista() async {
    if (isCamposValidos()) {
      return helper.findByTurma(turma!);
    }
    return [];
  }

  void _buscar() {
    setState(() {
      buscaDadosParaLista();
    });
  }

  @override
  CadNotaAlunoPage criarTelaCadastro(AlunoTurma? dado) =>
      CadNotaAlunoPage(dado!);

  @override
  Future<Widget?> subtitle(AlunoTurma dado) async =>
      _calculaResultado(dado.aluno!);

  @override
  String textoDeExibicao(AlunoTurma dado) => dado.aluno!.nome;

  Future<Widget> _calculaResultado(Aluno aluno) async {
    final mediaDaNotaDoAluno =
        await notaAlunoHelper.getSomaDasNotasByTurmaDisciplinaAndAluno(
                turma!, disciplina!, aluno) /
            2;
    String texto;
    if (mediaDaNotaDoAluno == null || mediaDaNotaDoAluno < 60) {
      texto = 'Reprovado Por Nota';
    } else {
      final totalFrequenciaDaTurmaDisciplina =
          await frequenciaHelper.getByTurmaDisciplina(turma!, disciplina!);
      final frequenciaDoAluno = await frequenciaHelper
          .getByTurmaDisciplinaAlunoPresentes(turma!, disciplina!, aluno);
      final porcentagemDeFrequenciaDoAluno =
          frequenciaDoAluno / totalFrequenciaDaTurmaDisciplina;
      if (porcentagemDeFrequenciaDoAluno < 0.7) {
        texto = 'Reprovado Por Frequência';
      } else {
        return const Text('Aprovado',
            style: TextStyle(fontSize: 20, color: Colors.green));
      }
    }
    return Text(texto, style: const TextStyle(fontSize: 20, color: Colors.red));
  }
}
