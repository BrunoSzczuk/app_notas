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
      floatingActionButton: !floatingButtonEnabled()
          ? null
          : FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _abrirTelaCadastro(null),
      ),
      body: ListView(children: [
        ...widgets(),
        FutureBuilder(
          future: buscaDadosParaLista(),
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
        )
      ]),
    );
  }

  Future<List<T>> buscaDadosParaLista() => helper.getAll();

  floatingButtonEnabled() => true;

  slideEnabled() => true;

  tapEnabled() => true;

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
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Dismissible(
            key: UniqueKey(),
            direction: slideEnabled()
                ? DismissDirection.horizontal
                : DismissDirection.none,
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

  ListTile _criaListTileComSubtitle(T dado) =>
      ListTile(
        title: Text(textoDeExibicao(dado)),
        subtitle: FutureBuilder<Widget?>(
          future: subtitle(dado),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!;
            }
            return const Text('');
          },
        ),
      );

  ListTile _criaListTileSemSubtitle(T dado) =>
      ListTile(
        title: Text(textoDeExibicao(dado)),
      );

  Widget _criarItemLista(T dado) {
    return GestureDetector(
      child: Card(
        child: FutureBuilder<Widget?>(
          future: subtitle(dado),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _criaListTileComSubtitle(dado);
            }
            return _criaListTileSemSubtitle(dado);
          },
        ),
      ),
      onTap: () => tapEnabled() ? _abrirTelaCadastro(dado) : null,
    );
  }

  String textoDeExibicao(T dado);

  CAD criarTelaCadastro(T? dado);

  List<Widget> widgets() => [];

  Future<Widget?> subtitle(T dado) async => null;
}
