import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jardineira_flutter/drawer_list.dart';
import 'package:jardineira_flutter/pages/menu.dart';
import 'package:jardineira_flutter/util/info_dialog.dart';
import 'package:jardineira_flutter/pages/settings_page.dart';
import 'package:jardineira_flutter/util/constantes.dart';
import 'package:jardineira_flutter/util/button_error_dialog.dart';
import 'package:jardineira_flutter/util/nav.dart';
import 'package:jardineira_flutter/util/wifi_info.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:weather_icons/weather_icons.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
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

  onUpdate() {
    setState(() {
      value = !value;
    });
  }

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
          Padding(
            padding: EdgeInsets.all(16),
            child: _dadosAmbienteStreamBuilder(),
          ),
          _dadosJardineiraStreamBuilder(),
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
          return Card(
            shape: StadiumBorder(),
            elevation: 10,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
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
                    ],
                  ),
                  SizedBox(height: 30),
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
                            value: snapshot.data.snapshot
                                        .value[Constantes.NIVEL_MAXIMO] ==
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
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => InfoDialog(
                                      "Nível de Água do Reservatório",
                                      snapshot.data.snapshot.value[
                                                  Constantes.NIVEL_MAXIMO] ==
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
                      SizedBox(width: 16),
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
                                snapshot.data.snapshot
                                    .value[Constantes.UMIDADE_SOLO]
                                    .toString() +
                                "%"),
                            circularStrokeCap: CircularStrokeCap.butt,
                            progressColor: _umidadeConvert(snapshot) > 0.40
                                ? Colors.green
                                : Colors.red,
                          ),
                          // _sensorRelativoSTB(
                          //     snapshot, "Umidade do Solo", "umidade_solo"),
                        ],
                      ),
                      SizedBox(width: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FaIcon(FontAwesomeIcons.faucet),

                          // _bigCircle(),
                          _sensorBooleanSTB(snapshot, "Válvula de Água",
                              Constantes.VALVULA_STATUS)
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  StreamBuilder(
                    initialData: false,
                    builder: (context, snapshot) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FloatingActionButton.extended(
                            heroTag: "btnRegar",
                            icon: value
                                ? Icon(Icons.local_florist_outlined)
                                : Icon(Icons.local_florist),
                            backgroundColor:
                                value ? Colors.lightGreen : Colors.yellow[300],
                            label: value ? Text("REGAR") : Text("REGANDO"),
                            elevation: 25.00,
                            onPressed: () {
                              onUpdate();
                              acionarRega();
                              estadoRega();
                              print("Onpressed Valor: $value");
                              // readData();
                            },
                          ),
                          SizedBox(width: 10),
                          FloatingActionButton.extended(
                            heroTag: "btnSettings",
                            backgroundColor: Colors.grey[300],
                            label: Icon(Icons.settings),
                            elevation: 25.00,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SettingsPage(),
                                ),
                              );
                              // showDialog(
                              //   context: context,
                              //   builder: (_) =>
                              //       InfoDialog("Configurações", "configuração"),
                              // );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
        // return Container();
      },
      stream: dbRef.child(Constantes.PATH_SENSORES).onValue,
    );
  }

  Column _sensorRelativoSTB(
      AsyncSnapshot<Event> snapshot, String titulo, String sensor) {
    String _simbolo;

    if (sensor == Constantes.TEMPERATURA) {
      _simbolo = "°";
    } else {
      _simbolo = "%";
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(titulo,
              style: TextStyle(
                  color: Colors.green[300],
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: snapshot.data.snapshot.value[sensor] == 0
              ? ButtonErrorDialog("Falha", Constantes.ERRO_LEITURA_SENSOR)
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      snapshot.data.snapshot.value[sensor].toString() +
                          _simbolo,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    // Icon(sensor == Constantes.TEMPERATURA
                    //     ? WeatherIcons.celsius
                    //     : WeatherIcons.humidity),
                  ],
                ),
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
        Text(
          sensor == Constantes.VALVULA_STATUS
              ? !snapshot.data.snapshot.value[Constantes.VALVULA_STATUS] == true
                  ? "REGANDO"
                  : "DESLIGADA"
              : snapshot.data.snapshot.value[sensor] == true
                  ? "SIM"
                  : "NÃO",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ],
    );
  }

  _dadosAmbienteStreamBuilder() {
    return StreamBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              !snapshot.hasError &&
              snapshot.data.snapshot.value != null) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: _sensorRelativoSTB(
                        snapshot, "Temperatura", Constantes.TEMPERATURA)),
                Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: _sensorRelativoSTB(snapshot, "Umidade do Ar",
                        Constantes.UMIDADE_RELATIVA)),
              ],
            );
          } else {}
          return Container();
        },
        stream: dbRef.child(Constantes.PATH_DADOS_AMBIENTE).onValue);
  }

  Future<void> acionarRega() async {
    dbRef.child(Constantes.PATH_ACIONAMENTOS).set({Constantes.REGA: !value});
  }

  Future<void> estadoRega() async {
    dbRef.child(Constantes.PATH_ACIONAMENTOS).onValue.listen((event) {
      var snapshot = event.snapshot;
      print(snapshot.value);
    });
  }

  // Future<void> estadoRega() async {
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
