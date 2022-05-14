import 'package:app_notas/datasources/local/aluno_helper.dart';
import 'package:app_notas/datasources/local/base/base_helper.dart';
import 'package:app_notas/datasources/local/disciplina_helper.dart';
import 'package:app_notas/datasources/local/frequencia_aluno_helper.dart';
import 'package:app_notas/datasources/local/turma_helper.dart';
import 'package:app_notas/datasources/models/aluno.dart';
import 'package:app_notas/datasources/models/base/base_model.dart';
import 'package:app_notas/datasources/models/disciplina.dart';
import 'package:app_notas/datasources/models/frequencia_aluno.dart';
import 'package:app_notas/datasources/models/turma.dart';
import 'package:app_notas/ui/components/mensagem_alerta.dart';
import 'package:app_notas/ui/pages/base/base_cad_page.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CadFrequenciaAlunoPage extends BaseCadPage {
  CadFrequenciaAlunoPage(BaseModel objeto) : super(objeto);

  @override
  BaseCadPageState<BaseCadPage, BaseModel, BaseHelper<BaseModel>>
      createState() => CadFrequenciaAlunoState();
}

class CadFrequenciaAlunoState extends BaseCadPageState<CadFrequenciaAlunoPage,
    FrequenciaAluno, FrequenciaAlunoHelper> {
  CadFrequenciaAlunoState()
      : super(
          FrequenciaAlunoHelper(),
          'Cadastro Frequencia de Aluno',
        );
  final turmaHelper = TurmaHelper();
  final disciplinaHelper = DisciplinaHelper();
  final alunoHelper = AlunoHelper();
  final alunoTurmaHelper = AlunoTurmaHelper();
  Turma? turma;
  Disciplina? disciplina;
  Set<FrequenciaAluno> frequencias = <FrequenciaAluno>{};
  DateTime? data;

  @override
  bool validar() {
    if (turma == null) {
      MensagemAlerta.alerta(context: context, texto: 'Turma é obrigatória!');
      return false;
    }
    if (disciplina == null) {
      MensagemAlerta.alerta(
          context: context, texto: 'Disciplina é obrigatória!');
      return false;
    }
    if (data == null) {
      MensagemAlerta.alerta(context: context, texto: 'Data é obrigatória!');
      return false;
    }
    return true;
  }

  bool isCamposValidos() => disciplina != null && turma != null && data != null;

  @override
  void salvar() {
    if (validar()) {
      for (var element in frequencias) {
        helper.save(element);
      }
      Navigator.pop(context);
    }
  }

  void _limpar() {
    frequencias.clear();
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
      DateTimeField(
          selectedDate: data,
          mode: DateTimeFieldPickerMode.date,
          decoration: const InputDecoration(labelText: 'Data'),
          dateFormat: DateFormat('dd/MM/yyyy'),
          onDateSelected: (DateTime value) {
            setState(() {
              data = value;
              _limpar();
            });
          }),
      ElevatedButton(
          onPressed: _buscar,
          child: const Text('Buscar'),
          style: ElevatedButton.styleFrom(primary: Colors.green)),
      FutureBuilder<Set<FrequenciaAluno>?>(
          future: criaFrequencia(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              frequencias = snapshot.data!.toSet();
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data!.elementAt(index).aluno!.nome),
                      leading: Checkbox(
                        value: snapshot.data!.elementAt(index).presente,
                        onChanged: (value) {
                          setState(() {
                            snapshot.data!.elementAt(index).presente = value;
                          });
                        },
                      ),
                    );
                  });
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    ];
  }

  @override
  void preencheCamposComObjeto(FrequenciaAluno? objeto) {
    if (objeto != null) {
      if (objeto.turma != null) {
        turma = objeto.turma;
      }
      if (objeto.disciplina != null) {
        disciplina = objeto.disciplina;
      }
    }
  }

  Future<Set<FrequenciaAluno>?> criaFrequencia() async {
    Set<FrequenciaAluno>? retorno = frequencias;
    if (isCamposValidos()) {
      List<AlunoTurma?> alunosTurma =
          await alunoTurmaHelper.findByTurma(turma!);

      for (AlunoTurma? alunoTurma in alunosTurma) {
        alunoTurma = alunoTurma!;
        List<FrequenciaAluno> frequencias =
            await helper.getByTurmaDisciplinaAndDateAndAluno(
                alunoTurma.turma!, disciplina!, data, alunoTurma.aluno!);
        if (frequencias.isNotEmpty) {
          retorno.add(frequencias.first);
        } else {
          retorno.add(FrequenciaAluno(
              turma: alunoTurma.turma,
              disciplina: disciplina,
              aluno: alunoTurma.aluno,
              data: data.toString(),
              presente: false));
        }
      }
    }
    return retorno;
  }

  void _buscar() {
    if (validar()) {
      setState(() {
        criaFrequencia();
      });
    }
  }

  @override
  void preSalvar() {}
}
