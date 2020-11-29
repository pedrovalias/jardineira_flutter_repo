import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:jardineira_flutter/util/constantes.dart';
import 'package:jardineira_flutter/util/info_dialog.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  double _tempoRegaPadrao = 5;
  double _tempoLoopPadrao = 10;
  double _limiarSecoPadrao = 20;

  final dbRef = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Configurações"),
      ),
      body: StreamBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              !snapshot.hasError &&
              snapshot.data.snapshot.value != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text("Limiar Seco: "),
                      _sliderConfiguracao(_limiarSecoPadrao, 0, 100, 100),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Tempo Loop: "),
                      _sliderConfiguracao(_tempoLoopPadrao, 0, 100, 100),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Tempo Rega: "),
                      _sliderConfiguracao(_tempoRegaPadrao, 0, 100, 100),
                    ],
                  ),
                  FlatButton(
                    child: Text("Teste"),
                    color: Colors.cyan,
                    onPressed: () {
                      _salvarConfig();
                      showDialog(
                        context: context,
                        builder: (_) => InfoDialog("ok", "ok"),
                      );
                    },
                  ),
                ],
              ),
            );
          } else {
            return Container(
              child: Text("Erro ao carregar dados do firebase."),
            );
          }
        },
        stream: dbRef.child(Constantes.PATH_ACIONAMENTOS).onValue,
      ),
    );
  }

  Slider _sliderConfiguracao(
    double parametro,
    double min,
    double max,
    int divisions,
  ) {
    return Slider(
      value: parametro,
      min: min,
      max: max,
      divisions: divisions,
      label: parametro.round().toString(),
      onChanged: (double novoValor) {
        setState(() {
          parametro = novoValor;
        });
      },
    );
  }

  void _salvarConfig() {}
}
