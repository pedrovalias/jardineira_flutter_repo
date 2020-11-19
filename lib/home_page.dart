import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jardineira_flutter/drawer_list.dart';
import 'package:jardineira_flutter/pages/info_dialog.dart';
import 'package:jardineira_flutter/pages/settings_page.dart';
import 'package:jardineira_flutter/util/nav.dart';
import 'package:jardineira_flutter/util/wifi_info.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

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
      drawer: DrawerList(),
    );
  }

  StreamBuilder<Event> _dadosJardineiraStreamBuilder() {
    return StreamBuilder(
      builder: (context, snapshot) {
        bool nivel_maximo = snapshot.data.snapshot.value["nivel_maximo"];

        int umidade_solo = snapshot.data.snapshot.value["umidade_solo"];

        if (snapshot.hasData &&
            !snapshot.hasError &&
            snapshot.data.snapshot.value != null) {
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
                            value: nivel_maximo == true ? 0.85 : 0.20,
                            valueColor: AlwaysStoppedAnimation(Colors.blue),
                            backgroundColor: Colors.white,
                            borderColor: Colors.grey[300],
                            borderWidth: 5.0,
                            direction: Axis.vertical,
                            center: Container(
                              child: FlatButton(
                                child: Icon(
                                  Icons.opacity,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => InfoDialog(
                                        "Nível de Água do Reservatório",
                                        nivel_maximo == true
                                            ? "O reservatório está cheio. Nenhuma ação necessária."
                                            : "O reservatório está incompleto."),
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
                            center:
                                Text("Solo\n" + umidade_solo.toString() + "%"),
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
                          // _bigCircle(),
                          _sensorBooleanSTB(
                              snapshot, "Válvula de Água", "valvula_status")
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
                            backgroundColor: Colors.grey[300],
                            label: Icon(Icons.settings),
                            elevation: 25.00,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) =>
                                    InfoDialog("Configurações", "configuração"),
                              );
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
      stream: dbRef.child("Jardineira_x/Sensores").onValue,
    );
  }

  Column _sensorRelativoSTB(
      AsyncSnapshot<Event> snapshot, String titulo, String sensor) {
    String _simbolo;

    if (sensor == "temperatura") {
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
          child: Text(
            snapshot.data.snapshot.value[sensor].toString() + _simbolo,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
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
          sensor == "valvula_status"
              ? !snapshot.data.snapshot.value["valvula_status"] == true
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
                        snapshot, "Temperatura", "temperatura")),
                Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: _sensorRelativoSTB(
                        snapshot, "Umidade do Ar", "umidade_relativa")),
              ],
            );
          } else {}
          return Container();
        },
        stream: dbRef.child("Jardineira_x/Dados Ambiente").onValue);
  }

  Future<void> acionarRega() async {
    dbRef.child("Jardineira_x/Acionamentos").set({"rega": !value});
  }

  Future<void> estadoRega() async {
    dbRef.child("Jardineira_x/Acionamentos").onValue.listen((event) {
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
        .child("Jardineira_x/Acionamentos")
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
    umdd = snapshot.data.snapshot.value["umidade_solo"] / 100;
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
