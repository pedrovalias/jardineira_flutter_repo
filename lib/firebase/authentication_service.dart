import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jardineira_flutter/pages/api_response.dart';
import 'package:jardineira_flutter/pages/login/usuario.dart';
import 'package:jardineira_flutter/util/info_dialog.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
  }

  Future<String> signIn({String email, String password}) async {
    // try {
    //   await _firebaseAuth.signInWithEmailAndPassword(
    //       email: email, password: password);
    //   return "Signed In";
    // } on FirebaseAuthException catch (e) {
    //   return e.message;
    // }
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      final User fuser = (await _firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      // print("Firebase Nome: " + fuser.displayName);
      // print("Firebase Email: " + fuser.email);
      // print("Firebase Foto: " + fuser.photoUrl);

      // Cria um usuario do app
      final user = Usuario(
        nome: fuser.displayName,
        // login: fuser.email,
        email: fuser.email,
        // urlFoto: fuser.photoUrl,
      );
      user.save();

      print("USUARIO: $fuser");
      print("USUARIO: $user");
      print("USUARIO: " + fuser.email);
      // print("USUARIO: " + fuser.displayName);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // signUp(email: email, password: password);
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<String> signUp({String email, String password}) async {
    // try {
    //   await _firebaseAuth.createUserWithEmailAndPassword(
    //       email: email, password: password);
    //   return "Signed Up";
    // } on FirebaseAuthException catch (e) {
    //   return e.message;
    // }
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<ApiResponse> loginGoogle() async {
    try {
      // Login com o Google
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      print("Google User: ${googleUser.email}");

      // Credenciais para o Firebase
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Login no Firebase

      final User fuser =
          (await _firebaseAuth.signInWithCredential(credential)).user;
      // print("Firebase Nome: " + fuser.displayName);
      // print("Firebase Email: " + fuser.email);
      // print("Firebase Foto: " + fuser.photoUrl);

      // Cria um usuario do app
      final user = Usuario(
        nome: fuser.displayName,
        // login: fuser.email,
        email: fuser.email,
        urlFoto: fuser.photoUrl,
      );
      user.save();

      print("USUARIO: $fuser");
      print("USUARIO: $user");
      print("USUARIO: " + fuser.email);
      print("USUARIO: " + fuser.photoURL);
      // print("USUARIO: " + fuser.displayName);

      // Resposta genérica
      return ApiResponse.ok();
    } catch (error) {
      print("Firebase error $error");
      return ApiResponse.error(msg: "Não foi possível fazer o login");
    }
  }
}
