// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fritofacil/domain/controller/controluser.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? userEmail = ControlUserAuth.getUserEmail();

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Image.asset('assets/images/profile_pic.png')),
          Text(
            "Hola, ${userEmail ?? ''}!", // Aquí se mostrará el email del usuario si está disponible
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Image.asset('assets/images/github.png', width: 60),
              const SizedBox(width: 10),
              const Text(
                "", // Puedes agregar más información aquí si es necesario
                style: TextStyle(fontSize: 20),
              )
            ],
          )
        ],
      ),
    );
  }
}
