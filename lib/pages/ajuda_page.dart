import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajuda"),
      ),
      body: _body(),
    );
  }

  _body() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          Center(
            child: Text(
              "Aqui você encontrará todas as respostas para suas perguntas",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: <Widget>[
              // Image(image: null),
              Text("Os elementos com informações"),
            ],
          ),
        ],
      ),
    );
  }
}
