import 'package:app_notas/datasources/local/disciplina_helper.dart';
import 'package:app_notas/datasources/local/base/base_helper.dart';
import 'package:app_notas/datasources/models/base/base_model.dart';
import 'package:app_notas/datasources/models/professor.dart';
import 'package:app_notas/ui/components/campo_texto.dart';
import 'package:app_notas/ui/components/mensagem_alerta.dart';
import 'package:app_notas/ui/pages/base/base_cad_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../datasources/local/professor_helper.dart';
import '../../datasources/models/disciplina.dart';

class CadDisciplinaPage extends BaseCadPage {
  CadDisciplinaPage(BaseModel objeto) : super(objeto);

  @override
  BaseCadPageState<BaseCadPage, BaseModel, BaseHelper<BaseModel>>
      createState() => CadDisciplinaState();
}

class CadDisciplinaState
    extends BaseCadPageState<CadDisciplinaPage, Disciplina, DisciplinaHelper> {
  CadDisciplinaState()
      : super(
          DisciplinaHelper(),
          'Cadastro Disciplina',
        );
  final _nomeController = TextEditingController();
  final professorHelper = ProfessorHelper();
  Professor? professor;
  @override
  bool validar() {
    if (_nomeController.text.isEmpty) {
      MensagemAlerta.alerta(context: context, texto: 'Nome é obrigatório!');
      return false;
    }
    if (professor == null) {
      MensagemAlerta.alerta(context: context, texto: 'Professor é obrigatório!');
      return false;
    }
    return true;
  }


  @override
  void preSalvar() {
    (widget.objeto as Disciplina).nome = _nomeController.text;
    (widget.objeto as Disciplina).professor = professor!;
  }

  @override
  List<Widget> widgets() {
    return [
      CampoTexto(controller: _nomeController, texto: 'Nome'),
      FutureBuilder<List<Professor>>(
          future: professorHelper.getAll(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return DropdownButton<Professor>(
                  hint: const Text('Selecione um Professor'),
                  isExpanded: true,
                  value: professor,
                  onChanged: (value) {
                    setState(() {
                      professor = value;
                    });
                  },
                  items: snapshot.data?.map((professor) {
                    return DropdownMenuItem<Professor>(
                      value: professor,
                      child: Text(professor.nome),
                    );
                  }).toList());
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          })
    ];
  }

  @override
  void preencheCamposComObjeto(Disciplina? objeto) {
    if (objeto != null) {
      _nomeController.text = objeto.nome ?? '';
      if (objeto.professor != null) {
        professor = objeto.professor;
      }
    }
  }
}
