import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jardineira_flutter/drawer_list.dart';
import 'package:jardineira_flutter/pages/menu.dart';

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Jardineira Smart",
//           style: TextStyle(fontSize: 26),
//         ),
//       ),
//       body: _body(),
//       drawer: Menu(),
//     );
//   }

//   _body() {
//     return Container(
//       color: Colors.white,
//     );
//   }
// }
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
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
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: _tempAmbienteStreamBuilder(),
          ),
          _dadosStreamBuilder(),
        ],
      ),
      drawer: DrawerList(),
    );
  }

  StreamBuilder<Event> _dadosStreamBuilder() {
    return StreamBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              !snapshot.hasError &&
              snapshot.data.snapshot.value != null) {
            return Card(
              shape: StadiumBorder(),
              elevation: 10,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _sensorBooleanSTB(
                            snapshot, "Vaso Cheio", "nivel_maximo"),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _sensorRelativoSTB(
                            snapshot, "Umidade do Solo", "umidade_solo"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _sensorBooleanSTB(
                            snapshot, "Status Válvula", "valvula_status")
                      ],
                    ),
                    SizedBox(height: 30),
                    FloatingActionButton.extended(
                      icon: value
                          ? Icon(Icons.local_florist_outlined)
                          : Icon(Icons.local_florist),
                      backgroundColor: value ? Colors.white : Colors.lightGreen,
                      label: value ? Text("REGAR") : Text("REGANDO"),
                      elevation: 25.00,
                      onPressed: () {
                        onUpdate();
                        acionarRega();
                        estadoRega();
                      },
                    ),
                  ],
                ),
              ),
            );
          } else {}
          return Container();
        },
        stream: dbRef.child("JD_0001/Sensores").onValue);
  }

  Column _sensorRelativoSTB(
      AsyncSnapshot<Event> snapshot, String titulo, String sensor) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(titulo,
              style: TextStyle(
                  color: value ? Colors.white : Colors.green[300],
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(snapshot.data.snapshot.value[sensor].toString() + "%",
              style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
      ],
    );
  }

  Column _sensorBooleanSTB(
      AsyncSnapshot<Event> snapshot, String titulo, String sensor) {
    return Column(
      children: [
        Text(titulo,
            style: TextStyle(
                color: value ? Colors.white : Colors.green[300],
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        Text(
          sensor == "valvula_status"
              ? !snapshot.data.snapshot.value["valvula_status"] == true
                  ? "REGANDO"
                  : "DESLIGADA"
              : snapshot.data.snapshot.value[sensor] == 1
                  ? "SIM"
                  : "NÃO",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ],
    );
  }

  _tempAmbienteStreamBuilder() {
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
        stream: dbRef.child("JD_0001/Dados Ambiente").onValue);
  }

  Future<void> acionarRega() async {
    dbRef.child("JD_0001/Acionamentos").set({"Rega": !value});
  }

  Future<void> estadoRega() async {
    dbRef.child("JD_0001/Acionamentos").onValue.listen((event) {
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
    dbRef.child("Dados").once().then((DataSnapshot snapshot) {
      print(snapshot.value);
    });
  }
}
