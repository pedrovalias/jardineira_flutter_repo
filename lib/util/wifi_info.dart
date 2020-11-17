import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class WifiInfo extends StatelessWidget {
  final dbRef = FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        builder: (context, snapshot) {
          return snapshot.data.snapshot.value["conexao_status"] == true
              ? Icon(
                  Icons.wifi,
                  color: Colors.green,
                )
              : Icon(Icons.wifi_off);
        },
        stream: dbRef.child("Jardineira_x/Conexao").onValue);
  }
}
