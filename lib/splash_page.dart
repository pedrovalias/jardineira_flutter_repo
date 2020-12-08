// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:jardineira_flutter/pages/login/login_page.dart';
// import 'package:jardineira_flutter/pages/login/usuario.dart';
// import 'package:jardineira_flutter/util/nav.dart';

// import 'home_page.dart';

// class SplashPage extends StatefulWidget {
//   @override
//   _SplashPageState createState() => _SplashPageState();
// }

// class _SplashPageState extends State<SplashPage> {
//   @override
//   void initState() {
//     // Inicializar o banco de dados
//     // Future futureA = DatabaseHelper.getInstance().db;

//     Future futureB = Future.delayed(Duration(seconds: 3));

//     // Usuario
//     // Future<Usuario> futureC = Usuario.get();

//     Future<FirebaseUser> futureC = FirebaseAuth.instance.currentUser();

//     Future.wait([futureB, futureC]).then((List values) {
//       FirebaseUser user = values[2];
//       print(user);

//       if (user != null) {
//         push(context, HomePage(), replace: true);
//       } else {
//         push(context, LoginPage(), replace: true);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.blue[200],
//       child: Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
// }
