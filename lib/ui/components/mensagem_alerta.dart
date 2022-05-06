import 'package:flutter/material.dart';

class MensagemAlerta {
  static Future show(
      {required BuildContext context,
      required String titulo,
      required String texto,
      required List<Widget> botoes}) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(titulo),
            content: Text(texto),
            actions: botoes,
          );
        });
  }

  static Future alerta({required BuildContext context, required String texto}) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Alerta"),
            content: Text(texto),
            actions: [
              TextButton(
                  child: const Text('Ok'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ],
          );
        });
  }
}
