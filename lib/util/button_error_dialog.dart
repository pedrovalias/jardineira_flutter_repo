import 'package:flutter/material.dart';
import 'package:jardineira_flutter/pages/info_dialog.dart';

class ButtonErrorDialog extends StatelessWidget {
  String _titulo;
  String _msg;

  ButtonErrorDialog(this._titulo, this._msg);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Icon(
        Icons.report_problem,
        color: Colors.yellow,
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => InfoDialog(_titulo, _msg),
        );
      },
    );
  }
}
