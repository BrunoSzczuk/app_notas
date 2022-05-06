import 'package:app_notas/datasources/local/disciplina_helper.dart';
import 'package:app_notas/datasources/local/base/base_helper.dart';
import 'package:app_notas/datasources/models/base/base_model.dart';
import 'package:app_notas/ui/components/campo_texto.dart';
import 'package:app_notas/ui/components/mensagem_alerta.dart';
import 'package:app_notas/ui/pages/base/base_cad_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../datasources/models/disciplina.dart';

class CadDisciplinaPage extends BaseCadPage {
  CadDisciplinaPage(BaseModel objeto) : super(objeto);

  @override
  BaseCadPageState<BaseCadPage, BaseModel, BaseHelper<BaseModel>>
      createState() => CadDisciplinaState();
}

class CadDisciplinaState extends BaseCadPageState<CadDisciplinaPage, Disciplina, DisciplinaHelper> {
  CadDisciplinaState()
      : super(
          DisciplinaHelper(),
          'Cadastro Disciplina',
        );
  final _nomeController = TextEditingController();

  @override
  bool validar() {
    if (_nomeController.text.isEmpty) {
      MensagemAlerta.alerta(context: context, texto: 'Nome é obrigatório!');
      return false;
    }
    return true;
  }

  @override
  void preSalvar() {
    (widget.objeto as Disciplina).nome = _nomeController.text;
  }

  @override
  List<Widget> widgets() {
    return [CampoTexto(controller: _nomeController, texto: 'Nome')];
  }

  @override
  void preencheCamposComObjeto(Disciplina? objeto) {
    if (objeto != null) {
      _nomeController.text = objeto.nome;
    }
  }
}
