import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text("Pedro"),
                accountEmail: Text("pedro@pedro.com.br"),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.blue,
                ),
              ),
              _MenuItem(
                context,
                Icons.star,
                "Favoritos",
                "Mais informações..",
                Icons.arrow_forward,
              ),
              _MenuItem(
                context,
                Icons.help,
                "Ajuda",
                "Mais informações..",
                Icons.arrow_forward,
              ),
              _MenuItem(
                context,
                Icons.settings,
                "Configurações",
                "",
                null,
              ),
              _MenuItem(
                context,
                Icons.logout,
                "Logout",
                "Aperte para sair",
                null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _MenuItem(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    IconData icon2,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Icon(icon2),
      onTap: () {
        print("Clicou $title");
        Navigator.pop(context);
      },
    );
  }
}
