import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fritofacil/src/feed/screen/cart_screen.dart';
import 'package:fritofacil/src/controller/product_controller.dart';
import 'package:fritofacil/src/feed/widget/product_grid_view.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getFavoriteItems();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favoritos",
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GetBuilder(
          builder: (ProductController controller) {
            return ProductGridView(
              items: controller.filteredProducts,
              likeButtonPressed: (index) => controller.isFavorite(index),
              isPriceOff: (product) => controller.isPriceOff(product),
            );
          },
        ),
      ),
    );
  }
}
