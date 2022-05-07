import 'package:app_notas/datasources/local/disciplina_helper.dart';
import 'package:app_notas/datasources/local/base/base_helper.dart';
import 'package:app_notas/datasources/models/disciplina.dart';
import 'package:app_notas/datasources/models/base/base_model.dart';
import 'package:app_notas/datasources/models/turma.dart';
import 'package:app_notas/ui/components/mensagem_alerta.dart';
import 'package:app_notas/ui/pages/base/base_cad_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../datasources/local/turma_helper.dart';

class CadDisciplinaTurmaPage extends BaseCadPage {
  CadDisciplinaTurmaPage(BaseModel objeto) : super(objeto);

  @override
  BaseCadPageState<BaseCadPage, BaseModel, BaseHelper<BaseModel>>
      createState() => CadDisciplinaTurmaState();
}

class CadDisciplinaTurmaState
    extends BaseCadPageState<CadDisciplinaTurmaPage, DisciplinaTurma, DisciplinaTurmaHelper> {
  CadDisciplinaTurmaState()
      : super(
          DisciplinaTurmaHelper(),
          'Cadastro Disciplina x Turma',
        );
  Disciplina? disciplina;
  Turma? turma;
  DisciplinaHelper disciplinaHelper = DisciplinaHelper();
  TurmaHelper turmaHelper = TurmaHelper();

  @override
  bool validar() {
    if (turma == null) {
      MensagemAlerta.alerta(context: context, texto: 'Selecione uma turma!');
      return false;
    }
    if (disciplina == null) {
      MensagemAlerta.alerta(context: context, texto: 'Selecione um disciplina!');
      return false;
    }
    return true;
  }

  @override
  void preSalvar() {
    (widget.objeto as DisciplinaTurma).disciplina = disciplina!;
    (widget.objeto as DisciplinaTurma).turma = turma!;
  }

  @override
  List<Widget> widgets() {
    return [
      const Text('Selecione um disciplina'),
      FutureBuilder<List<Disciplina>>(
        future: disciplinaHelper.getAll(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return DropdownButton<Disciplina>(
              isExpanded: true,
              value: disciplina,
              items: snapshot.data?.map((disciplina) {
                return DropdownMenuItem<Disciplina>(
                  value: disciplina,
                  child: Text(disciplina.nome!),
                );
              }).toList(),
              onChanged: (disciplina) {
                setState(() {
                  this.disciplina = disciplina;
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
  void preencheCamposComObjeto(DisciplinaTurma? objeto) {
    if (objeto != null) {
      disciplina = objeto.disciplina;
      turma = objeto.turma;
    }
  }
}
