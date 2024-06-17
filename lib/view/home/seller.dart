// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class GestionVendedor extends StatelessWidget {
  const GestionVendedor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestión de Vendedor'),
      ),
      body: Center(
        child: Text('Pantalla de Gestión de Vendedor'),
      ),
    );
  }
}
