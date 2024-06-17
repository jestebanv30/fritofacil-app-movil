// ignore_for_file: avoid_print, prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fritofacil/data/services/peticionuser.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ControlUserAuth extends GetxController {
  final _response = Rxn();
  final _emailLocal = Rxn();
  final _passwordLocal = Rxn();
  final _mensaje = "".obs;
  final Rxn<UserCredential> _user = Rxn<UserCredential>();
  final _role = ''.obs;

  Future<void> saveLocal() async {
    GetStorage _dataLocal = GetStorage();
    _dataLocal.write('email', _user.value!.user!.email);
    _dataLocal.write('password', _passwordLocal.value);
  }

  Future<void> seeLocal() async {
    GetStorage _dataLocal = GetStorage();
    _emailLocal.value = _dataLocal.read('email');
    _passwordLocal.value = _dataLocal.read('password');
    print(_emailLocal.value);
  }

  Future<void> controlUser(dynamic response) async {
    if (response is UserCredential) {
      _mensaje.value = 'Proceso realizado correctamente';
      _user.value = response;
      await saveLocal();
      await _fetchUserRole();
    } else if (response == '1' || response == '2') {
      _mensaje.value = 'Datos incorrectos';
    } else {
      _mensaje.value = 'No se completó la consulta';
    }
  }

  Future<void> createUser(String email, String password) async {
    try {
      _response.value = await PeticionesLogin.createEmail(email, password);
      _passwordLocal.value = password;
      print(_response.value);
      await controlUser(_response.value);
      if (_user.value != null) {
        // Iniciar sesión automáticamente después de registrarse
        await _assignUserRole(
            'cliente'); // Asignar rol de administrador para prueba
        await Future.delayed(Duration(
            seconds: 1)); // Esperar a que el rol se actualice en Firestore
        await loginUser(email, password);
      }
    } catch (e) {
      _mensaje.value = 'Error al crear usuario: $e';
    }
  }

  Future<void> loginUser(String email, String password) async {
    print('Starting loginUser with email: $email');
    _response.value = await PeticionesLogin.loginEmail(email, password);
    _passwordLocal.value = password;
    print('Login response: $_response.value');
    await controlUser(_response.value);
    print('Completed controlUser');
  }

  Future<void> _assignUserRole(String role) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'role': role,
      });
    }
  }

  Future<void> _fetchUserRole() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      _role.value = doc.data()?['role'] ?? 'cliente';
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    _user.value = null;
    _role.value = '';

    // Navegar a la pantalla de inicio ("/home")
    Get.offAllNamed('/home');
  }

  String get role => _role.value;
  dynamic get passwordLocal => _passwordLocal.value;
  dynamic get emailLocal => _emailLocal.value;
  dynamic get estadouser => _response.value;
  String get mensajesUser => _mensaje.value;
  UserCredential? get userValido => _user.value;
}
