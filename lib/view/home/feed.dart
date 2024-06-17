// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fritofacil/domain/controller/controluser.dart';
import 'package:get/get.dart';

class FeedPrincipal extends StatelessWidget {
  const FeedPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    ControlUserAuth cua = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Text('Feed Principal'),
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
      body: ListView(
        children: [
          ListTile(
            leading: Image.network('https://via.placeholder.com/150'),
            title: Text('Plato 1'),
            subtitle: Text('Descripción del Plato 1'),
            trailing: Text('\$10.00'),
          ),
          ListTile(
            leading: Image.network('https://via.placeholder.com/150'),
            title: Text('Plato 2'),
            subtitle: Text('Descripción del Plato 2'),
            trailing: Text('\$12.00'),
          ),
          ListTile(
            leading: Image.network('https://via.placeholder.com/150'),
            title: Text('Plato 3'),
            subtitle: Text('Descripción del Plato 3'),
            trailing: Text('\$15.00'),
          ),
        ],
      ),
    );
  }
}
