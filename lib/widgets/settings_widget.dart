import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:jardineira_flutter/util/constantes.dart';
import 'package:jardineira_flutter/util/info_dialog.dart';

class SettingsWidget extends StatefulWidget {
  @override
  _SettingsWidgetState createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  // double _novoLimiarSeco = 0;
  // double _novoTempoLoop = 0;
  // double _novoTempoRega = 0;

  // int _tempoRega;

  double _valor1 = 2;
  double _valor2 = 2;
  double _valor3 = 2;
  bool _valor4 = true;

  final dbRef = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            !snapshot.hasError &&
            snapshot.data.snapshot.value != null) {
          // TODO transformar lista de configuracao em ListTile

          // _tempoRega = snapshot.data.snapshot.value[Constantes.TEMPO_REGA];
          // int _tempoLoop =
          //     snapshot.data.snapshot.value[Constantes.TEMPO_LOOP];
          // int _limiarSeco =
          //     snapshot.data.snapshot.value[Constantes.LIMIAR_SECO];

          // double _tempoRegaPadrao = _tempoRega.toDouble();
          // double _tempoLoopPadrao = _tempoLoop.toDouble();
          // double _limiarSecoPadrao = _limiarSeco.toDouble();

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              height: 600,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: ListTile(
                      // leading: Icon(Icons.ac_unit),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Ajuste automático de tempo:",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          FlutterSwitch(
                            value: _valor4,
                            borderRadius: 30.0,
                            padding: 8.0,
                            showOnOff: true,
                            onToggle: (val) {
                              setState(() {
                                _valor4 = val;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  _divider(),
                  Expanded(
                    child: ListTile(
                      leading: IconButton(
                        splashColor: Colors.amber,
                        splashRadius: 20,
                        icon: Icon(
                          Icons.help_outline,
                          color: Colors.lightBlue,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => InfoDialog("Umidade do Solo",
                                Constantes.INFO_UMIDADE_SOLO_SLIDER),
                          );
                        },
                      ),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Umidade do Solo",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  snapshot.data.snapshot
                                      .value[Constantes.LIMIAR_SECO]
                                      .toString(),
                                )
                              ],
                            ),
                          ),
                          Slider(
                            value: _valor1,
                            min: 0,
                            max: 100,
                            onChanged: (double v) {
                              setState(() {
                                _valor1 = v;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  _divider(),
                  Expanded(
                    child: ListTile(
                      leading: IconButton(
                        splashColor: Colors.amber,
                        splashRadius: 20,
                        icon: Icon(
                          Icons.help_outline,
                          color: Colors.lightBlue,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => InfoDialog("Tempo do Loop",
                                Constantes.INFO_TEMPO_LOOP_SLIDER),
                          );
                        },
                      ),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Tempo Loop",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  snapshot.data.snapshot
                                      .value[Constantes.TEMPO_LOOP]
                                      .toString(),
                                )
                              ],
                            ),
                          ),
                          Slider(
                            value: _valor2,
                            min: 0,
                            max: 100,
                            onChanged: (double v) {
                              setState(() {
                                _valor2 = v;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  _divider(),
                  Expanded(
                    child: ListTile(
                      leading: IconButton(
                        splashColor: Colors.amber,
                        splashRadius: 20,
                        icon: Icon(
                          Icons.help_outline,
                          color: Colors.lightBlue,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => InfoDialog("Tempo de Rega",
                                Constantes.INFO_TEMPO_REGA_SLIDER),
                          );
                        },
                      ),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Tempo Rega",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  snapshot.data.snapshot
                                      .value[Constantes.TEMPO_REGA]
                                      .toString(),
                                )
                              ],
                            ),
                          ),
                          Slider(
                            value: _valor3,
                            min: 0,
                            max: 100,
                            onChanged: (double v) {
                              setState(() {
                                _valor3 = v;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  _divider(),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                          child: Text(
                            "Configuração Padrão",
                            style: TextStyle(fontSize: 18),
                          ),
                          color: Colors.cyan,
                          onPressed: () {
                            _configPadrao();
                            showDialog(
                              context: context,
                              builder: (_) => InfoDialog(
                                  "Configuraçãopadrão salva com sucesso!", ""),
                            );
                          },
                        ),
                        SizedBox(width: 30),
                        FlatButton(
                          child: Text(
                            "Salvar",
                            style: TextStyle(fontSize: 18),
                          ),
                          color: Colors.lightGreen,
                          onPressed: () {
                            _salvarConfig();
                            _recuperaDados();
                            showDialog(
                              context: context,
                              builder: (_) => InfoDialog(
                                  "Configuração personalizada salva com sucesso!",
                                  ""),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container(
            child: Text("Erro ao carregar dados do firebase."),
          );
        }
      },
      stream: dbRef.child(Constantes.PATH_ACIONAMENTOS).onValue,
    );
  }

  Future<void> _salvarConfig() async {
    dbRef.child(Constantes.PATH_ACIONAMENTOS).set({
      Constantes.LIMIAR_SECO: _valor1,
      Constantes.TEMPO_LOOP: _valor2,
      Constantes.TEMPO_REGA: _valor3,
      Constantes.AUTO_AJUSTE_LOOP: _valor4,
    });
  }

  Future<void> _configPadrao() async {
    double _limiarPadrao = 75;
    double _loopPadrao = 9;
    double _regaPadrao = 15;

    // _limiarSecoPadrao = _limiarPadrao;
    // _tempoLoopPadrao = _loopPadrao;
    // _tempoRegaPadrao = _regaPadrao;

    dbRef.child(Constantes.PATH_ACIONAMENTOS).set({
      Constantes.LIMIAR_SECO: _limiarPadrao,
      Constantes.TEMPO_LOOP: _loopPadrao,
      Constantes.TEMPO_REGA: _regaPadrao
    });
  }

  Future<void> _recuperaDados() async {
    dbRef
        .child(Constantes.PATH_ACIONAMENTOS)
        .once()
        .then((DataSnapshot snapshot) {
      print(snapshot.value);
      // snapshot.data.snapshot.value[];
    });
  }

  _divider() {
    return const Divider(
      color: Colors.grey,
      height: 30,
      thickness: 0.5,
    );
  }

  // void _validaAlteracao() {
  //   if()

  // }

  // Slider _sliderConfiguracao(
  //   double parametro,
  //   double min,
  //   double max,
  //   int divisions,
  // ) {
  //   return Slider(
  //     value: parametro,
  //     min: min,
  //     max: max,
  //     divisions: divisions,
  //     label: parametro.round().toString(),
  //     onChanged: (double novoValor) {
  //       setState(() {
  //         parametro = novoValor;
  //       });
  //     },
  //   );
  // }

}
