import 'package:app_notas/datasources/local/aluno_helper.dart';
import 'package:app_notas/datasources/local/base/base_helper.dart';
import 'package:app_notas/datasources/local/disciplina_helper.dart';
import 'package:app_notas/datasources/local/nota_aluno_helper.dart';
import 'package:app_notas/datasources/local/turma_helper.dart';
import 'package:app_notas/datasources/models/aluno.dart';
import 'package:app_notas/datasources/models/base/base_model.dart';
import 'package:app_notas/datasources/models/disciplina.dart';
import 'package:app_notas/datasources/models/nota_aluno.dart';
import 'package:app_notas/datasources/models/turma.dart';
import 'package:app_notas/ui/pages/base/base_cad_page.dart';
import 'package:app_notas/ui/pages/base/base_list_page.dart';
import 'package:app_notas/ui/pages/cad_nota_aluno_page.dart';
import 'package:flutter/material.dart';

class ListNotaAlunoPage extends BaseListPage {
  @override
  BaseListPageState<BaseListPage, BaseModel, BaseHelper<BaseModel>,
      BaseCadPage<BaseModel>> createState() => ListNotaAlunoState();
}

class ListNotaAlunoState extends BaseListPageState<ListNotaAlunoPage, NotaAluno,
    NotaAlunoHelper, CadNotaAlunoPage> {
  ListNotaAlunoState()
      : super(
          NotaAlunoHelper(),
          'Lista de Notas de Aluno',
        );
  final turmaHelper = TurmaHelper();
  final disciplinaHelper = DisciplinaHelper();
  final alunoHelper = AlunoHelper();
  final alunoTurmaHelper = AlunoTurmaHelper();
  Turma? turma;
  Disciplina? disciplina;
  Set<NotaAluno> notasAluno = <NotaAluno>{};
  int bimestre = 1;

  @override
  floatingButtonEnabled() => false;

  bool isCamposValidos() => disciplina != null && turma != null;

  void _limpar() {
    notasAluno.clear();
  }

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
                      _limpar();
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
                    _limpar();
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
      const Text('Bimestre'),
      DropdownButton<int>(
        hint: const Text('Selecione um Bimestre'),
        isExpanded: true,
        value: bimestre,
        onChanged: (value) {
          setState(() {
            bimestre = value!;
            _limpar();
          });
        },
        items: <int>[1, 2].map((bimestre) {
          return DropdownMenuItem<int>(
            value: bimestre,
            child: Text(bimestre.toString()),
          );
        }).toList(),
      ),
      ElevatedButton(
          onPressed: _buscar,
          child: const Text('Buscar'),
          style: ElevatedButton.styleFrom(primary: Colors.green)),
    ];
  }

  @override
  slideEnabled() => false;

  @override
  Future<List<NotaAluno>> buscaDadosParaLista() async {
    List<NotaAluno>? retorno = notasAluno.toList();
    if (isCamposValidos()) {
      List<AlunoTurma?> alunosTurma =
          await alunoTurmaHelper.findByTurma(turma!);

      for (AlunoTurma? alunoTurma in alunosTurma) {
        alunoTurma = alunoTurma!;
        List<NotaAluno> frequencias =
            await helper.getByTurmaDisciplinaAndBimestreAndAluno(
                alunoTurma.turma!, disciplina!, bimestre, alunoTurma.aluno!);
        if (frequencias.isNotEmpty) {
          retorno.add(frequencias.first);
        } else {
          retorno.add(NotaAluno(
              turma: alunoTurma.turma,
              disciplina: disciplina,
              aluno: alunoTurma.aluno,
              bimestre: bimestre));
        }
      }
    }
    return retorno;
  }

  void _buscar() {
    setState(() {
      buscaDadosParaLista();
    });
  }

  @override
  CadNotaAlunoPage criarTelaCadastro(NotaAluno? dado) =>
      CadNotaAlunoPage(dado!);

  @override
  String textoDeExibicao(NotaAluno dado) => dado.aluno!.nome;
}
