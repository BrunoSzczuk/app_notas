import 'package:app_notas/datasources/local/aluno_helper.dart';
import 'package:app_notas/datasources/local/base/base_helper.dart';
import 'package:app_notas/datasources/models/base/base_model.dart';
import 'package:app_notas/ui/components/campo_texto.dart';
import 'package:app_notas/ui/components/mensagem_alerta.dart';
import 'package:app_notas/ui/pages/base/base_cad_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../datasources/models/aluno.dart';

class CadAlunoPage extends BaseCadPage {
  CadAlunoPage(BaseModel objeto) : super(objeto);

  @override
  BaseCadPageState<BaseCadPage, BaseModel, BaseHelper<BaseModel>>
      createState() => CadAlunoState();
}

class CadAlunoState extends BaseCadPageState<CadAlunoPage, Aluno, AlunoHelper> {
  CadAlunoState()
      : super(
          AlunoHelper(),
          'Cadastro Aluno',
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
    (widget.objeto as Aluno).nome = _nomeController.text;
  }

  @override
  List<Widget> widgets() {
    return [CampoTexto(controller: _nomeController, texto: 'Nome')];
  }

  @override
  void preencheCamposComObjeto(Aluno? objeto) {
    if (objeto != null) {
      _nomeController.text = objeto.nome;
    }
  }
}
