// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:fritofacil/domain/controller/controluser.dart';
import 'package:get/get.dart';

class GestionAdmin extends StatelessWidget {
  const GestionAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    ControlUserAuth cua = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestión de Administrador'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              cua.logout().then((value) {
                Get.offAllNamed('/home');
              });
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Datos Estadísticos de Ventas',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  Card(
                    child: ListTile(
                      title: Text('Ventas Totales'),
                      subtitle: Text('\$10,000'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text('Productos más Vendidos'),
                      subtitle: Text('Producto 1, Producto 2, Producto 3'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text('Clientes Activos'),
                      subtitle: Text('500'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text('Feedback de Clientes'),
                      subtitle: Text('Muy satisfechos con el servicio'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
