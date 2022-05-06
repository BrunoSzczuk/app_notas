import 'package:app_notas/datasources/local/base/base_helper.dart';
import 'package:app_notas/datasources/models/base/base_model.dart';
import 'package:app_notas/ui/components/mensagem_alerta.dart';
import 'package:app_notas/ui/pages/base/base_cad_page.dart';
import 'package:flutter/material.dart';

abstract class BaseListPage extends StatefulWidget {
  @override
  BaseListPageState createState();
}

abstract class BaseListPageState<X extends BaseListPage, T extends BaseModel,
    S extends BaseHelper<T>, CAD extends BaseCadPage> extends State<X> {
  final S helper;
  final String title;

  BaseListPageState(this.helper, this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _abrirTelaCadastro(null),
      ),
      body: FutureBuilder(
        future: helper.getAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              }
              return _criarLista(snapshot.data as List<T>);
          }
        },
      ),
    );
  }

  void _abrirTelaCadastro(T? dado) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => criarTelaCadastro(dado),
      ),
    );
    setState(() {});
  }

  Widget _criarLista(List<T> data) {
    return ListView.builder(
        padding: const EdgeInsets.all(4),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.horizontal,
            child: _criarItemLista(data[index]),
            background: Container(
              alignment: const Alignment(-1, 0),
              color: Colors.blue,
              child: const Text(
                'Editar',
                style: TextStyle(color: Colors.white),
              ),
            ),
            secondaryBackground: Container(
              alignment: const Alignment(1, 0),
              color: Colors.red,
              child: const Text(
                'Excluir',
                style: TextStyle(color: Colors.white),
              ),
            ),
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.startToEnd) {
                _abrirTelaCadastro(data[index]);
              } else if (direction == DismissDirection.endToStart) {
                helper.delete(data[index]);
              }
            },
            confirmDismiss: (DismissDirection direction) async {
              if (direction == DismissDirection.endToStart) {
                return await MensagemAlerta.show(
                    context: context,
                    titulo: 'Atenção',
                    texto: 'Deseja excluir esse registro?',
                    botoes: [
                      TextButton(
                          child: const Text('Sim'),
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          }),
                      ElevatedButton(
                          child: const Text('Não'),
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          }),
                    ]);
              }
              return true;
            },
          );
        });
  }

  Widget _criarItemLista(T dado) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Text(
                mostrarNome(dado),
                style: const TextStyle(fontSize: 28),
              ),
            ],
          ),
        ),
      ),
      onTap: () => _abrirTelaCadastro(dado),
    );
  }

  String mostrarNome(T dado);

  CAD criarTelaCadastro(T? dado);
}
