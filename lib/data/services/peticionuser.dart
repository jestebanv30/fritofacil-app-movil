// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, no_leading_underscores_for_local_identifiers

import 'package:firebase_auth/firebase_auth.dart';

//Servicio para la autenticacion de correo y contaseña

class PeticionesLogin {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<dynamic> createEmail(dynamic email, dynamic password) async {
    try {
      UserCredential _user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print("funcion " + _user.toString());
      return _user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('Contraseña debil');
        return 1;
      } else if (e.code == 'email-already-in-use') {
        print('Correo existente');
        return 2;
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> loginEmail(dynamic email, dynamic password) async {
    try {
      UserCredential _user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return _user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("Correo no encontrado");
        return 1;
      } else if (e.code == 'rong-password') {
        print('Contraseña incorrecta');
        return 2;
      }
    }
  }
}
