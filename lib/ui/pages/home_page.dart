import 'package:app_notas/ui/pages/list_aluno_page.dart';
import 'package:app_notas/ui/pages/list_disciplina_page.dart';
import 'package:app_notas/ui/pages/list_professor_page.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lançamento de Notas'),
        ),
        body: ListView(
          children: [
            ElevatedButton(
                child: const Text("Lista de Alunos"),
                onPressed: () {
                  _abrirTelaListaAluno(context);
                }),
            ElevatedButton(
                child: const Text("Lista de Professores"),
                onPressed: () {
                  _abrirTelaListaProfessor(context);
                }),
            ElevatedButton(
                child: const Text("Lista de Disciplinas"),
                onPressed: () {
                  _abrirTelaListaDisciplina(context);
                }),
            ElevatedButton(
                child: const Text("Cadastro de Turmas"), onPressed: () {}),
            ElevatedButton(
                child: const Text("Lançamento de Notas"), onPressed: () {}),
            ElevatedButton(
                child: const Text("Lançamento de Frequência"),
                onPressed: () {}),
            ElevatedButton(
                child: const Text("Resultado Final"), onPressed: () {}),
          ],
        ));
  }

  void _abrirTelaListaAluno(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ListAlunoPage()));
  }

  void _abrirTelaListaProfessor(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ListProfessorPage()));
  }

  void _abrirTelaListaDisciplina(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ListDisciplinaPage()));
  }
}
