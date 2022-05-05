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
            ElevatedButton(child: const Text("Cadastro de Alunos"), onPressed: () {}),
            ElevatedButton(child: const Text("Cadastro de Professores"), onPressed: () {}),
            ElevatedButton(child: const Text("Cadastro de Disciplinas"), onPressed: () {}),
            ElevatedButton(child: const Text("Cadastro de Turmas"), onPressed: () {}),
            ElevatedButton(child: const Text("Lançamento de Notas"), onPressed: () {}),
            ElevatedButton(child: const Text("Lançamento de Frequência"), onPressed: () {}),
            ElevatedButton(child: const Text("Resultado Final"), onPressed: () {}),
          ],
        ));
  }
}
