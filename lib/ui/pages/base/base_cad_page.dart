import 'package:app_notas/datasources/local/base/base_helper.dart';
import 'package:app_notas/datasources/models/base/base_model.dart';
import 'package:app_notas/ui/components/mensagem_alerta.dart';
import 'package:flutter/material.dart';

abstract class BaseCadPage<T extends BaseModel> extends StatefulWidget {
  late final T objeto;

  @override
  BaseCadPageState createState();

  BaseCadPage(this.objeto);
}

abstract class BaseCadPageState<X extends BaseCadPage, T extends BaseModel,
    S extends BaseHelper<T>> extends State<X> {
  final S helper;
  final String title;

  BaseCadPageState(this.helper, this.title);

  @override
  void initState() {
    super.initState();
    preencheCamposComObjeto(widget.objeto as T);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        children: [
          ...widgets(),
          ElevatedButton(onPressed: salvar, child: const Text('Salvar')),
          Visibility(
            child: ElevatedButton(
                child: const Text('Excluir'), onPressed: excluir),
            visible: widget.objeto.id != null,
          ),
        ],
      ),
    );
  }

  bool validar();

  List<Widget> widgets();

  void preSalvar();

  void excluir() {
    MensagemAlerta.show(
        context: context,
        titulo: 'Atenção',
        texto: 'Deseja excluir esse registro?',
        botoes: [
          TextButton(child: const Text('Sim'), onPressed: _confirmarExclusao),
          ElevatedButton(
              child: const Text('Não'),
              onPressed: () {
                Navigator.pop(context);
              }),
        ]);
  }

  void salvar() {
    if (validar()) {
      preSalvar();
      helper.save(widget.objeto as T);
      Navigator.pop(context);
    }
  }

  void _confirmarExclusao() {
    helper.delete(widget.objeto as T);
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void preencheCamposComObjeto(T? objeto);
}
