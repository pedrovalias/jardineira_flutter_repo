import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:jardineira_flutter/util/info_dialog.dart';
import 'package:jardineira_flutter/util/constantes.dart';

class WifiInfo extends StatelessWidget {
  final dbRef = FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            !snapshot.hasError &&
            snapshot.data.snapshot.value != null) {
          // bool _conexao_status =
          //     snapshot.data.snapshot.value[Constantes.CONEXAO_STATUS];
          return FlatButton(
            minWidth: 10,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            child:
                snapshot.data.snapshot.value[Constantes.CONEXAO_STATUS] == true
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
                  snapshot.data.snapshot.value[Constantes.CONEXAO_STATUS] ==
                          true
                      ? Constantes.WIFI_OK +
                          snapshot.data.snapshot.value[Constantes.CONEXAO_IP]
                      : Constantes.WIFI_NOK,
                ),
              );
            },
          );
        } else {
          return Container();
        }
      },
      stream: dbRef.child(Constantes.PATH_CONEXAO).onValue,
    );
  }
}
