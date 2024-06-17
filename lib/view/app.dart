// ignore_for_file: prefer_const_constructors

import 'dart:ui' show PointerDeviceKind;

import 'package:flutter/material.dart';
import 'package:fritofacil/core/app_theme.dart';
import 'package:fritofacil/src/feed/screen/home_screen.dart';
import 'package:fritofacil/view/auth/login.dart';
import 'package:fritofacil/view/auth/register.dart';
import 'package:fritofacil/view/home/admin.dart';
import 'package:fritofacil/view/home/home.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
        },
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: AppTheme.lightAppTheme,
      getPages: [
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/homeScreen', page: () => HomeScreen()),
        GetPage(name: '/admin', page: () => GestionAdmin()),
      ],
    );
  }
}
