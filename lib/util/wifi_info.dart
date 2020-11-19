import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:jardineira_flutter/pages/info_dialog.dart';

class WifiInfo extends StatelessWidget {
  final dbRef = FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (context, snapshot) {
        bool _conexao_status = snapshot.data.snapshot.value["conexao_status"];
        return FlatButton(
          minWidth: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          child: _conexao_status == true
              ? Icon(
                  Icons.wifi,
                  color: Colors.green,
                )
              : Icon(Icons.wifi_off),
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => InfoDialog(
                  "Conexão Wifi",
                  _conexao_status == true
                      ? "Jardineira está conectada."
                      : "Jardineira está desconectada."),
            );
          },
        );
      },
      stream: dbRef.child("Jardineira_x/Conexao").onValue,
    );
  }
}
