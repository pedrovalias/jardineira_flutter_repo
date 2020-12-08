// import 'package:auth_buttons/auth_buttons.dart';
// import 'package:flutter/material.dart';
// import 'package:jardineira_flutter/firebase/firebase_service.dart';
// import 'package:jardineira_flutter/pages/login/login_bloc.dart';
// import 'package:jardineira_flutter/pages/login/usuario.dart';
// import 'package:jardineira_flutter/util/alert.dart';
// import 'package:jardineira_flutter/util/nav.dart';
// import 'package:jardineira_flutter/widgets/app_button.dart';
// import 'package:jardineira_flutter/widgets/app_text.dart';

// import '../../home_page.dart';
// import '../api_response.dart';

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();

//   // final _bloc = LoginBloc();

//   final _tLogin = TextEditingController();

//   final _tSenha = TextEditingController();

//   final _focusSenha = FocusNode();

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Carros"),
//       ),
//       body: _body(),
//     );
//   }

//   _body() {
//     return Form(
//       key: _formKey,
//       child: Container(
//         padding: EdgeInsets.all(16),
//         child: ListView(
//           children: <Widget>[
//             AppText(
//               "Login",
//               "Digite o login",
//               controller: _tLogin,
//               validator: (s) => _validateLogin(s),
//               keyboardType: TextInputType.emailAddress,
//               textInputAction: TextInputAction.next,
//               nextFocus: _focusSenha,
//             ),
//             SizedBox(height: 10),
//             AppText(
//               "Senha",
//               "Digite a senha",
//               controller: _tSenha,
//               password: true,
//               validator: _validateSenha,
//               keyboardType: TextInputType.number,
//               focusNode: _focusSenha,
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             // StreamBuilder<bool>(
//             //   stream: _bloc.stream,
//             //   initialData: false,
//             //   builder: (context, snapshot) {
//             //     return AppButton(
//             //       "Login",
//             //       onPressed: _onClickLogin,
//             //       showProgress: snapshot.data,
//             //     );
//             //   },
//             // ),
//             Container(
//               height: 46,
//               margin: EdgeInsets.only(top: 20),
//               child: GoogleAuthButton(
//                 onPressed: _onClickGoogle,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   _onClickGoogle() async {
//     final service = FirebaseService();
//     ApiResponse response = await service.loginGoogle();

//     if (response.ok) {
//       push(context, HomePage(), replace: true);
//     } else {
//       alert(context, response.msg);
//     }
//   }

//   void _onClickLogin() async {
//     if (!_formKey.currentState.validate()) {
//       return;
//     }

//     String login = _tLogin.text;
//     String senha = _tSenha.text;

//     print("Login: $login, Senha: $senha");

//     // ApiResponse<Usuario> response = await _bloc.login(login, senha);

//     push(context, HomePage(), replace: true);

//     // if (response.ok) {
//     //   push(context, HomePage(), replace: true);
//     // } else {
//     //   alert(context, response.msg);
//     // }
//   }

//   String _validateLogin(String text) {
//     if (text.isEmpty) {
//       return "Digite o login";
//     }
//     return null;
//   }

//   String _validateSenha(String text) {
//     if (text.isEmpty) {
//       return "Digite a senha";
//     }
//     if (text.length < 3) {
//       return "A senha precisa ter pelo menos 3 números";
//     }
//     return null;
//   }

//   @override
//   void dispose() {
//     super.dispose();

//     _bloc.dispose();
//   }
// }

import 'package:auth_buttons/res/buttons/google_auth_button.dart';
import 'package:flutter/material.dart';
import 'package:jardineira_flutter/firebase/authentication_service.dart';
import 'package:jardineira_flutter/util/alert.dart';
import 'package:jardineira_flutter/util/nav.dart';
import 'package:jardineira_flutter/widgets/app_button.dart';
import 'package:jardineira_flutter/widgets/app_text.dart';
import 'package:jardineira_flutter/widgets/home_page_teste.dart';
import 'package:provider/provider.dart';

import '../api_response.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final _focusSenha = FocusNode();

  bool _showProgress = false;

  @override
  Widget build(BuildContext context) {
    _showProgress = false;
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Form(
        child: Container(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: <Widget>[
              AppText(
                "Email",
                "Digite o seu email",
                controller: emailController,
                validator: (s) => _validateLogin(s),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                nextFocus: _focusSenha,
              ),
              SizedBox(height: 10),
              AppText(
                "Senha",
                "Digite a sua senha",
                controller: passwordController,
                password: true,
                validator: _validateSenha,
                keyboardType: TextInputType.number,
                focusNode: _focusSenha,
              ),
              SizedBox(height: 30),
              AppButton(
                "Sign In",
                onPressed: () {
                  // if (!_formKey.currentState.validate()) {
                  //   return;
                  // }
                  setState(() {
                    _showProgress = true;
                  });
                  _showProgress = true;

                  context.read<AuthenticationService>().signIn(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim());
                  setState(() {
                    _showProgress = false;
                  });
                },
                showProgress: _showProgress,
              ),
              Container(
                height: 46,
                margin: EdgeInsets.only(top: 20),
                child: GoogleAuthButton(
                  onPressed: () async {
                    context.read<AuthenticationService>().loginGoogle();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _validateLogin(String text) {
    if (text.isEmpty) {
      return "Digite o login";
    }
    return null;
  }

  String _validateSenha(String text) {
    if (text.isEmpty) {
      return "Digite a senha";
    }
    if (text.length < 3) {
      return "A senha precisa ter pelo menos 3 números";
    }
    return null;
  }
}
