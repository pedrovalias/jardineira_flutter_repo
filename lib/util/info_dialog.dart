import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoDialog extends StatelessWidget {
  String titulo;
  String msg;

  InfoDialog(this.titulo, this.msg);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.info),
          SizedBox(
            height: 10,
          ),
          Text(titulo),
        ],
      ),
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(msg),
      ),
      actions: [
        CupertinoDialogAction(
          child: Text("OK"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
