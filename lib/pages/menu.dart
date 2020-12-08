import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jardineira_flutter/firebase/authentication_service.dart';
import 'package:jardineira_flutter/pages/login/usuario.dart';
import 'package:provider/provider.dart';

class Menu extends StatelessWidget {
  // const Menu({Key key, @required this.user}) : super(key: key);
  // final FirebaseUser user;

  @override
  Widget build(BuildContext context) {
    Future<Usuario> future = Usuario.get();

    return SafeArea(
      child: Container(
        child: Drawer(
          child: ListView(
            children: <Widget>[
              FutureBuilder<Usuario>(
                future: future,
                builder: (context, snapshot) {
                  Usuario user = snapshot.data;

                  return user != null ? _header(user) : Container();
                },
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

  UserAccountsDrawerHeader _header(Usuario user) {
    return UserAccountsDrawerHeader(
      accountName: Text(user.nome != null ? user.nome : "Teste"),
      accountEmail: Text(user.email),
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage(user.urlFoto != null
            ? user.urlFoto
            : "https://www.computerhope.com/jargon/g/guest-user.jpg"),
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
        if (title == "Logout") {
          context.read<AuthenticationService>().signOut();
        } else {
          print("Clicou $title");
          Navigator.pop(context);
        }
      },
    );
  }
}
