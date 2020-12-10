import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jardineira_flutter/pages/menu.dart';
import 'package:jardineira_flutter/util/info_dialog.dart';
import 'package:jardineira_flutter/pages/settings_page.dart';
import 'package:jardineira_flutter/util/constantes.dart';
import 'package:jardineira_flutter/util/button_error_dialog.dart';
import 'package:jardineira_flutter/util/nav.dart';
import 'package:jardineira_flutter/util/wifi_info.dart';
import 'package:jardineira_flutter/widgets/settings_widget.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:slimy_card/slimy_card.dart';
import 'package:weather_icons/weather_icons.dart';

class HomePageTeste extends StatefulWidget {
  // const HomePageTeste({Key key, @required this.user}) : super(key: key);

  // final FirebaseUser user;

  @override
  _HomePageTesteState createState() => _HomePageTesteState();
}

class _HomePageTesteState extends State<HomePageTeste>
    with SingleTickerProviderStateMixin {
  // final _streamController = StreamController<bool>();

  @override
  final dbRef = FirebaseDatabase.instance.reference();
  bool value = false;
  Color color = Colors.grey;

  // @override
  // void initState() {
  //   super.initState();
  // }

  // onUpdate() {
  //   setState(() {
  //     value = !value;
  //   });
  // }

  static final GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      appBar: AppBar(
        title: Text("Jardineira Smart"),
      ),
      key: _scaffoldKey,
      body: Column(
        children: <Widget>[
          Expanded(child: _dadosJardineiraStreamBuilder()),
        ],
      ),
      drawer: Menu(),
    );
  }

  StreamBuilder<Event> _dadosJardineiraStreamBuilder() {
    return StreamBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            !snapshot.hasError &&
            snapshot.data.snapshot.value != null) {
          // bool nivel_maximo =
          //     snapshot.data.snapshot.value[Constantes.NIVEL_MAXIMO];
          // int umidade_solo =
          //     snapshot.data.snapshot.value[Constantes.UMIDADE_SOLO];
          double _valor = 2;
          return ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: SlimyCard(
                  color: Colors.grey[600],
                  width: 390,
                  topCardHeight: 200,
                  bottomCardHeight: 600,
                  borderRadius: 15,
                  topCardWidget: _topCardWidget(snapshot, context),
                  bottomCardWidget: SettingsWidget(),
                  slimeEnabled: true,
                ),
              ),
            ],
          );
        } else {
          return Container();
        }
        // return Container();
      },
      stream: dbRef.child(Constantes.PATH_SENSORES).onValue,
    );
  }

  Column _topCardWidget(AsyncSnapshot<Event> snapshot, BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Jardineira_x",
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(width: 8),
            WifiInfo(),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: _dadosAmbienteStreamBuilder(),
            ),
          ],
        ),
        // SizedBox(height: 30),
        _divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                alignment: Alignment.center,
                height: 60,
                width: 60,
                // color: Colors.yellow,
                child: LiquidCircularProgressIndicator(
                  value:
                      snapshot.data.snapshot.value[Constantes.NIVEL_MAXIMO] ==
                              true
                          ? 0.85
                          : 0.20,
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                  backgroundColor: Colors.white,
                  borderColor: Colors.grey[300],
                  borderWidth: 5.0,
                  direction: Axis.vertical,
                  center: Container(
                    child: FlatButton(
                      child: Icon(
                        Icons.waves,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => InfoDialog(
                            "Nível de Água do Reservatório",
                            snapshot.data.snapshot
                                        .value[Constantes.NIVEL_MAXIMO] ==
                                    true
                                ? Constantes.RESERVATORIO_OK
                                : Constantes.RESERVATORIO_NOK,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),
            // _sensorBooleanSTB(
            //     snapshot, "Vaso Cheio", "nivel_maximo"),
            // SizedBox(width: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularPercentIndicator(
                  radius: 60.0,
                  animation: true,
                  animationDuration: 1200,
                  lineWidth: 5.0,
                  percent: _umidadeConvert(snapshot),
                  center: Text("Solo\n" +
                      snapshot.data.snapshot.value[Constantes.UMIDADE_SOLO]
                          .toString() +
                      "%"),
                  circularStrokeCap: CircularStrokeCap.butt,
                  progressColor: _umidadeConvert(snapshot) > 0.40
                      ? Colors.green
                      : Colors.red,
                ),
              ],
            ),
            SizedBox(width: 16),
            ClipOval(
              child: Material(
                color: Colors.grey[300], // button color
                child: InkWell(
                  splashColor: Colors.grey[300], // inkwell color
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: Center(
                      child: ClipOval(
                        child: Material(
                          color: snapshot.data.snapshot
                                      .value[Constantes.VALVULA_STATUS] ==
                                  false
                              ? Colors.green
                              : Colors.red, // button color
                          child: InkWell(
                            splashColor: Colors.grey[300], // inkwell color
                            child: SizedBox(
                                width: 50,
                                height: 50,
                                child: Center(
                                    child: FaIcon(FontAwesomeIcons.faucet))),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (_) => InfoDialog(
                                  "Status da Válvula de Água",
                                  snapshot.data.snapshot.value[
                                              Constantes.VALVULA_STATUS] ==
                                          false
                                      ? Constantes.VALVULA_ON
                                      : Constantes.VALVULA_OFF,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            FloatingActionButton.extended(
              heroTag: "btnRegar",
              icon: snapshot.data.snapshot.value[Constantes.VALVULA_STATUS] ==
                      true
                  ? Icon(Icons.local_florist_outlined)
                  : Icon(Icons.local_florist),
              backgroundColor:
                  snapshot.data.snapshot.value[Constantes.VALVULA_STATUS] ==
                          true
                      ? Colors.lightGreen
                      : Colors.yellow[300],
              label: snapshot.data.snapshot.value[Constantes.VALVULA_STATUS] ==
                      true
                  ? Text("REGAR")
                  : Text("REGANDO"),
              elevation: 25.00,
              onPressed: () {
                // onUpdate();
                acionarRega();
                // Future<void> i = estadoRega();
                // print("Onpressed Valor: $value");
                // print("Onpressed Valor I: ${i}");
                // readData();
              },
            ),
          ],
        ),
        SizedBox(height: 30),
        // ClipOval(
        //   child: Material(
        //     color: Colors.grey[300], // button color
        //     child: InkWell(
        //       splashColor: Colors.grey[300], // inkwell color
        //       child: SizedBox(
        //         width: 60,
        //         height: 60,
        //         child: Center(
        //           child: ClipOval(
        //             child: Material(
        //               color:
        //                   snapshot.data.snapshot.value[Constantes.REGA] == true
        //                       ? Colors.green
        //                       : Colors.red, // button color
        //               child: InkWell(
        //                 splashColor: Colors.grey[300], // inkwell color
        //                 child: SizedBox(
        //                     width: 50,
        //                     height: 50,
        //                     child: Center(
        //                         child: Icon(Icons.local_florist_outlined))),
        //                 onTap: () {
        //                   onUpdate();
        //                   // acionarRega();
        //                   // showDialog(
        //                   //   context: context,
        //                   //   builder: (_) => InfoDialog(
        //                   //     "Status da Válvula de Água",
        //                   //     snapshot.data.snapshot
        //                   //                 .value[Constantes.VALVULA_STATUS] ==
        //                   //             false
        //                   //         ? Constantes.VALVULA_ON
        //                   //         : Constantes.VALVULA_OFF,
        //                   //   ),
        //                   // );
        //                 },
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     FloatingActionButton.extended(
        //       heroTag: "btnRegar",
        //       icon: snapshot.data.snapshot.value[Constantes.VALVULA_STATUS] ==
        //               true
        //           ? Icon(Icons.local_florist_outlined)
        //           : Icon(Icons.local_florist),
        //       backgroundColor:
        //           snapshot.data.snapshot.value[Constantes.VALVULA_STATUS] ==
        //                   true
        //               ? Colors.lightGreen
        //               : Colors.yellow[300],
        //       label: snapshot.data.snapshot.value[Constantes.VALVULA_STATUS] ==
        //               true
        //           ? Text("REGAR")
        //           : Text("REGANDO"),
        //       elevation: 25.00,
        //       onPressed: () {
        //         // onUpdate();
        //         acionarRega();
        //         // estadoRega();
        //         print("Onpressed Valor: $value");
        //         // readData();
        //       },
        //     ),
        //     SizedBox(width: 10),
        //   ],
        // ),
      ],
    );
  }

  Row _sensorRelativoSTB(AsyncSnapshot<Event> snapshot, String sensor) {
    String _simbolo;

    if (sensor == Constantes.TEMPERATURA) {
      _simbolo = "°C";
    } else {
      _simbolo = "%";
    }

    return Row(
      children: [
        snapshot.data.snapshot.value[sensor] == 0
            ? ButtonErrorDialog("Falha", Constantes.ERRO_LEITURA_SENSOR)
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    snapshot.data.snapshot.value[sensor].toString() + _simbolo,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
      ],
    );
  }

  Column _sensorBooleanSTB(
      AsyncSnapshot<Event> snapshot, String titulo, String sensor) {
    return Column(
      children: [
        Text(
          titulo,
          style: TextStyle(
            color: Colors.green[300],
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        // Text(
        //   sensor == Constantes.VALVULA_STATUS
        //       ? !snapshot.data.snapshot.value[Constantes.VALVULA_STATUS] == true
        //           ? "REGANDO"
        //           : "DESLIGADA"
        //       : snapshot.data.snapshot.value[sensor] == true
        //           ? "SIM"
        //           : "NÃO",
        //   style: TextStyle(color: Colors.white, fontSize: 20),
        // ),
      ],
    );
  }

  _dadosAmbienteStreamBuilder() {
    return StreamBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              !snapshot.hasError &&
              snapshot.data.snapshot.value != null) {
            return FlatButton(
              minWidth: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(90)),
              child: Row(
                children: <Widget>[
                  _sensorRelativoSTB(snapshot, Constantes.TEMPERATURA),
                  SizedBox(
                    width: 5,
                  ),
                  Text("/"),
                  SizedBox(
                    width: 5,
                  ),
                  _sensorRelativoSTB(snapshot, Constantes.UMIDADE_RELATIVA),
                ],
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => InfoDialog(
                    "Dados do Ambiente",
                    Constantes.INFO_DADOS_AMBIENTE,
                  ),
                );
              },
            );
          } else {}
          return Container();
        },
        stream: dbRef.child(Constantes.PATH_DADOS_AMBIENTE).onValue);
  }

  Future<void> acionarRega() async {
    dbRef.child(Constantes.PATH_ACIONAMENTOS).update(({Constantes.REGA: true}));
  }

  // Future<void> estadoRega() async {
  //   dbRef.child(Constantes.PATH_ACIONAMENTOS).onValue.listen((event) {
  //     var snapshot = event.snapshot;
  //     print(snapshot.value);
  //   });
  // }

  // Future<void> estadoRega2() async {
  //   dbRef.child("Acionamentos").once().then((DataSnapshot snapshot) {
  //     print(snapshot.value);
  //   });
  // }

  Future<void> readData() async {
    dbRef
        .child(Constantes.PATH_ACIONAMENTOS)
        .once()
        .then((DataSnapshot snapshot) {
      print(snapshot.value);
    });
  }

  // Metodo responsavel por gerenciar a memoria das telas
  // @override
  // void dispose() {
  //   super.dispose();

  //   // Fechar o fluxo de dados
  //   _streamController.close();
  // }

  _umidadeConvert(snapshot) {
    double umdd;
    umdd = snapshot.data.snapshot.value[Constantes.UMIDADE_SOLO] / 100;
    // print(x);
    // print(y);
    return umdd;
  }

  _divider() {
    return const Divider(
      color: Colors.grey,
      height: 20,
      thickness: 0.5,
    );
  }

  // Widget _bigCircle() {
  //   return Container(
  //     alignment: Alignment.center,
  //     width: 60.0,
  //     height: 60.0,
  //     decoration: BoxDecoration(
  //       color: Colors.orange,
  //       shape: BoxShape.rectangle,
  //       borderRadius: BorderRadius.circular(16),
  //     ),
  //     child: Text("teste"),
  //   );
  // }
}
