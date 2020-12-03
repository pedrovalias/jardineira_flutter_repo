// import 'dart:async';

// import 'package:firebase/firestore.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:jardineira_flutter/pages/jardineira.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert' as convert;

// import 'package:jardineira_flutter/util/constantes.dart';

// // class JardineiraApi {
// //   static Future<List<JardineiraX>> getJardineiras() async {
// //     final dbRef = await FirebaseDatabase.instance.reference();

// //     // String json = dbRef.child("Jardineira_X").onValue.toString();

// //     List list = convert.    decode(dbRef.child("Jardineira_X").onValue());
// //     List<JardineiraX> jardineiras =
// //         list.map<JardineiraX>((map) => JardineiraX.fromJson(map)).toList();

// //     return jardineiras;
// //   }
// // }

// class JardineiraApi extends StatefulWidget {
//   // JardineiraApi({this.app});
//   // final FirebaseApp app;
//   @override
//   _JardineiraApiState createState() => _JardineiraApiState();
// }

// class _JardineiraApiState extends State<JardineiraApi>
//     with AutomaticKeepAliveClientMixin<JardineiraApi> {
//   DatabaseReference _counterRef;
//   DatabaseReference _messagesRef;
//   StreamSubscription<Event> _counterSubscription;
//   StreamSubscription<Event> _messagesSubscription;
//   @override
//   bool get wantKeepAlive => true;

//   @override
//   void initState() {
//     super.initState();
//     // Demonstrates configuring to the database using a file
//     _counterRef = FirebaseDatabase.instance.reference().child('counter');
//     // Demonstrates configuring the database directly
//     // final FirebaseDatabase database = FirebaseDatabase(app: widget.app);
//     _messagesRef = FirebaseDatabase.instance.reference().child('messages');
//     FirebaseDatabase.instance
//         .reference()
//         .child('counter')
//         .once()
//         .then((DataSnapshot snapshot) {
//       print('Connected to second database and read ${snapshot.value}');
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     super.build(context);

//     return StreamBuilder<QuerySnapshot>(
//         stream: _counterRef.child("Jardineira_X").onValue,
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Text("Não foi possível buscar jardineiras");
//           }

//           if (!snapshot.hasData) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           List<JardineiraX> jardineiras =
//               snapshot.data.docs.map((DocumentSnapshot document) {
//             return Jardineira.fromMap(document.data);
//           }).toList();

//           return Text("Carregou jardineiras");
//         });
//   }
// }
