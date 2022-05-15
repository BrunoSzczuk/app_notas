import 'package:app_notas/datasources/local/base/base_helper.dart';
import 'package:app_notas/datasources/local/nota_aluno_helper.dart';
import 'package:app_notas/datasources/models/base/base_model.dart';
import 'package:app_notas/datasources/models/nota_aluno.dart';
import 'package:app_notas/ui/components/mensagem_alerta.dart';
import 'package:app_notas/ui/pages/base/base_cad_page.dart';
import 'package:flutter/material.dart';

class CadNotaAlunoPage extends BaseCadPage {
  CadNotaAlunoPage(BaseModel objeto) : super(objeto);

  @override
  BaseCadPageState<BaseCadPage, BaseModel, BaseHelper<BaseModel>>
      createState() => CadNotaAlunoState();
}

class CadNotaAlunoState
    extends BaseCadPageState<CadNotaAlunoPage, NotaAluno, NotaAlunoHelper> {
  CadNotaAlunoState()
      : super(
          NotaAlunoHelper(),
          'Cadastro Nota de Aluno',
        );
  final _notaController = TextEditingController();
  final _nomeController = TextEditingController();

  @override
  bool validar() {
    if (_notaController.text.isEmpty) {
      MensagemAlerta.alerta(context: context, texto: 'A Nota é obrigatória!');
      return false;
    }
    int? nota = int.tryParse(_notaController.text.toString());
    if (nota == null || nota < 0 || nota > 100) {
      MensagemAlerta.alerta(
          context: context, texto: 'A Nota informada está incorreta!');
      return false;
    }
    if (_nomeController.text.isEmpty) {
      MensagemAlerta.alerta(context: context, texto: 'O Nome é obrigatório!');
      return false;
    }
    return true;
  }

  @override
  void preSalvar() {
    (widget.objeto as NotaAluno).nota =
        int.parse((widget.objeto as NotaAluno).nota!.toStringAsFixed(0));
  }

  @override
  void preencheCamposComObjeto(NotaAluno? objeto) {
    _notaController.text = (widget.objeto as NotaAluno).nota?.toString() ?? '';
    _nomeController.text = (widget.objeto as NotaAluno).aluno!.nome;
  }

  @override
  List<Widget> widgets() {
    return [
      TextFormField(
        controller: _nomeController,
        enabled: false,
        decoration: InputDecoration(
          labelText: (widget.objeto as NotaAluno).aluno!.nome,
        ),
      ),
      TextFormField(
        controller: _notaController,
        keyboardType: const TextInputType.numberWithOptions(),
        decoration: const InputDecoration(
          labelText: 'Nota',
        ),
        onChanged: (value) {
          (widget.objeto as NotaAluno).nota = int.tryParse(value);
        },
      ),
    ];
  }
}
