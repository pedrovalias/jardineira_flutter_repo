import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: new ListView(
          children: <Widget>[
            new DrawerHeader(
              child: new Text("DRAWER HEADER.."),
              decoration: new BoxDecoration(color: Colors.orange),
            ),
            new ListTile(
              title: new Text("Item 1"),
              onTap: () {},
            ),
            new ListTile(
              title: new Text("Item 2"),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
