import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// push recebendo como parametro opcional o booleano replace
Future push(BuildContext context, Widget page, {bool replace = false}) {
  // SE replace true, irá substituir uma tela pela outra ("destruir a anterior")
  if (replace) {
    return Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return page;
    }));
  }
  // Caso contrário, ele sobrepõe (permite que volte à tela anterior)
  return Navigator.push(context,
      MaterialPageRoute(builder: (BuildContext context) {
    return page;
  }));
}
