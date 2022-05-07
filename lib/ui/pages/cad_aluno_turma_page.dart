import 'package:app_notas/datasources/local/aluno_helper.dart';
import 'package:app_notas/datasources/local/base/base_helper.dart';
import 'package:app_notas/datasources/models/aluno.dart';
import 'package:app_notas/datasources/models/base/base_model.dart';
import 'package:app_notas/datasources/models/turma.dart';
import 'package:app_notas/ui/components/mensagem_alerta.dart';
import 'package:app_notas/ui/pages/base/base_cad_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../datasources/local/turma_helper.dart';

class CadAlunoTurmaPage extends BaseCadPage {
  CadAlunoTurmaPage(BaseModel objeto) : super(objeto);

  @override
  BaseCadPageState<BaseCadPage, BaseModel, BaseHelper<BaseModel>>
      createState() => CadAlunoTurmaState();
}

class CadAlunoTurmaState
    extends BaseCadPageState<CadAlunoTurmaPage, AlunoTurma, AlunoTurmaHelper> {
  CadAlunoTurmaState()
      : super(
          AlunoTurmaHelper(),
          'Cadastro Aluno x Turma',
        );
  Aluno? aluno;
  Turma? turma;
  AlunoHelper alunoHelper = AlunoHelper();
  TurmaHelper turmaHelper = TurmaHelper();

  @override
  bool validar() {
    if (turma == null) {
      MensagemAlerta.alerta(context: context, texto: 'Selecione uma turma!');
      return false;
    }
    if (aluno == null) {
      MensagemAlerta.alerta(context: context, texto: 'Selecione um aluno!');
      return false;
    }
    return true;
  }

  @override
  void preSalvar() {
    (widget.objeto as AlunoTurma).aluno = aluno!;
    (widget.objeto as AlunoTurma).turma = turma!;
  }

  @override
  List<Widget> widgets() {
    return [
      const Text('Selecione um aluno'),
      FutureBuilder<List<Aluno>>(
        future: alunoHelper.getAll(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return DropdownButton<Aluno>(
              isExpanded: true,
              value: aluno,
              items: snapshot.data?.map((aluno) {
                return DropdownMenuItem<Aluno>(
                  value: aluno,
                  child: Text(aluno.nome),
                );
              }).toList(),
              onChanged: (aluno) {
                setState(() {
                  this.aluno = aluno;
                });
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      const Text('Selecione uma turma'),
      FutureBuilder<List<Turma>>(
          future: turmaHelper.getAll(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return DropdownButton<Turma>(
                isExpanded: true,
                value: turma,
                items: snapshot.data?.map((turma) {
                  return DropdownMenuItem<Turma>(
                    value: turma,
                    child: Text(turma.nome),
                  );
                }).toList(),
                onChanged: (turma) {
                  setState(() {
                    this.turma = turma;
                  });
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    ];
  }

  @override
  void preencheCamposComObjeto(AlunoTurma? objeto) {
    if (objeto != null) {
      aluno = objeto.aluno;
      turma = objeto.turma;
    }
  }
}
