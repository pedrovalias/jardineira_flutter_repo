import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:jardineira_flutter/util/constantes.dart';
import 'package:jardineira_flutter/util/info_dialog.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  double _tempoRegaPadrao = 1;
  double _tempoLoopPadrao = 10;
  double _limiarSecoPadrao = 20;
  double _novoLimiarSeco = 0;
  double _novoTempoLoop = 0;
  double _novoTempoRega = 0;

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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text("Umidade do Solo: "),
                          IconButton(
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
                          Slider(
                            value: _limiarSecoPadrao,
                            min: 0,
                            max: 100,
                            divisions: 100,
                            label: _limiarSecoPadrao.round().toString() + " %",
                            onChanged: (double _novoValor) {
                              setState(() {
                                _limiarSecoPadrao = _novoValor;
                                _novoLimiarSeco = _limiarSecoPadrao;
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Tempo Loop: "),
                          IconButton(
                              icon: Icon(Icons.help_outline),
                              onPressed: () {
                                print("teste");
                              }),
                          Slider(
                            value: _tempoLoopPadrao,
                            min: 0,
                            max: 48,
                            divisions: 48,
                            label: _tempoLoopPadrao.round().toString() + " H",
                            onChanged: (double _novoValor) {
                              setState(() {
                                _tempoLoopPadrao = _novoValor;
                              });
                            },
                            onChangeEnd: (double _novoValor) {
                              print("último valor: $_novoValor");
                              _novoTempoLoop = _novoValor;
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Tempo Rega: "),
                          IconButton(
                            splashColor: Colors.amber,
                            splashRadius: 20,
                            icon: Icon(
                              Icons.help_outline,
                              color: Colors.lightBlue,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) => InfoDialog("Tempo Rega",
                                    Constantes.INFO_TEMPO_REGA_SLIDER),
                              );
                            },
                          ),
                          Slider(
                            activeColor: Colors.amber,
                            value: _tempoRegaPadrao,
                            min: 0,
                            max: 60,
                            divisions: 20,
                            label: _tempoRegaPadrao.round().toString() + " s",
                            onChanged: (double _novoValor) {
                              setState(() {
                                _tempoRegaPadrao = _novoValor;
                                _novoTempoRega = _tempoRegaPadrao;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          FlatButton(
                            child: Text("Configuração Padrão"),
                            color: Colors.cyan,
                            onPressed: () {
                              _configPadrao();
                              showDialog(
                                context: context,
                                builder: (_) => InfoDialog(
                                    "Configuraçãopadrão salva com sucesso!",
                                    ""),
                              );
                            },
                          ),
                          SizedBox(width: 30),
                          FlatButton(
                            child: Text("Salvar"),
                            color: Colors.lightGreen,
                            onPressed: () {
                              _salvarConfig();
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
                    ],
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

  Future<void> _salvarConfig() async {
    dbRef.child(Constantes.PATH_ACIONAMENTOS).set({
      Constantes.LIMIAR_SECO: _novoLimiarSeco,
      Constantes.TEMPO_LOOP: _novoTempoLoop,
      Constantes.TEMPO_REGA: _novoTempoRega
    });
  }

  Future<void> _configPadrao() async {
    double _limiarPadrao = 75;
    double _loopPadrao = 9;
    double _regaPadrao = 15;

    _limiarSecoPadrao = _limiarPadrao;
    _tempoLoopPadrao = _loopPadrao;
    _tempoRegaPadrao = _regaPadrao;

    dbRef.child(Constantes.PATH_ACIONAMENTOS).set({
      Constantes.LIMIAR_SECO: _limiarPadrao,
      Constantes.TEMPO_LOOP: _loopPadrao,
      Constantes.TEMPO_REGA: _regaPadrao
    });
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
