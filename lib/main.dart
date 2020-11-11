import 'package:flutter/material.dart';
import 'package:jardineira_flutter/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: HomePage(),
      themeMode: ThemeMode.dark,
    );
  }
}
