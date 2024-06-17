// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:fritofacil/core/app_data.dart';
import 'package:fritofacil/domain/controller/controluser.dart';
import 'package:fritofacil/src/feed/animation/page_transition_switcher_wrapper.dart';
import 'package:fritofacil/src/feed/screen/cart_screen.dart';
import 'package:fritofacil/src/feed/screen/favorite_screen.dart';
import 'package:fritofacil/src/feed/screen/product_list_screen.dart';
import 'package:fritofacil/src/feed/screen/profile_screen.dart';
import 'package:get/get.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const List<Widget> screens = [
    ProductListScreen(),
    FavoriteScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int newIndex = 0;
  final ControlUserAuth _authController = Get.find<ControlUserAuth>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  // Lógica para cerrar sesión usando el controlador
                  _authController.logout();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login', // Cambia esto por la ruta de tu pantalla de inicio de sesión
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
          bottomNavigationBar: StylishBottomBar(
            currentIndex: newIndex,
            onTap: (index) {
              newIndex = index;
              setState(() {});
            },
            items: AppData.bottomNavBarItems
                .map(
                  (item) => BottomBarItem(
                    backgroundColor: item.activeColor,
                    icon: item.icon,
                    title: Text(
                      item.title,
                      style: TextStyle(
                        color: item.activeColor,
                      ),
                    ),
                  ),
                )
                .toList(),
            option: BubbleBarOptions(
              opacity: 0.3,
              unselectedIconColor: Colors.grey,
              borderRadius: BorderRadius.circular(
                15.0,
              ),
            ),
          ),
          body: PageTransitionSwitcherWrapper(
            child: HomeScreen.screens[newIndex],
          ),
        ),
      ),
    );
  }
}
