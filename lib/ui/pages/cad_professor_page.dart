import 'package:app_notas/datasources/local/professor_helper.dart';
import 'package:app_notas/datasources/local/base/base_helper.dart';
import 'package:app_notas/datasources/models/base/base_model.dart';
import 'package:app_notas/ui/components/campo_texto.dart';
import 'package:app_notas/ui/components/mensagem_alerta.dart';
import 'package:app_notas/ui/pages/base/base_cad_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../datasources/models/professor.dart';

class CadProfessorPage extends BaseCadPage {
  CadProfessorPage(BaseModel objeto) : super(objeto);

  @override
  BaseCadPageState<BaseCadPage, BaseModel, BaseHelper<BaseModel>>
      createState() => CadProfessorState();
}

class CadProfessorState
    extends BaseCadPageState<CadProfessorPage, Professor, ProfessorHelper> {
  CadProfessorState()
      : super(
          ProfessorHelper(),
          'Cadastro Professor',
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
    (widget.objeto as Professor).nome = _nomeController.text;
  }

  @override
  List<Widget> widgets() {
    return [CampoTexto(controller: _nomeController, texto: 'Nome')];
  }

  @override
  void preencheCamposComObjeto(Professor? objeto) {
    if (objeto != null) {
      _nomeController.text = objeto.nome;
    }
  }
}
