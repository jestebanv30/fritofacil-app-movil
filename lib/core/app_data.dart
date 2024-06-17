import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fritofacil/src/model/bottom_nav_bar_item.dart';
import 'package:fritofacil/src/model/categorical.dart';
import 'package:fritofacil/src/model/numerical.dart';
import 'package:fritofacil/src/model/product.dart';
import 'package:fritofacil/src/model/product_category.dart';
import 'package:fritofacil/src/model/product_size_type.dart';
import 'package:fritofacil/src/model/recommended_product.dart';

class AppData {
  const AppData._();

  static const String dummyText =
      'Lorem Ipsum is simply dummy text of the printing and typesetting'
      ' industry. Lorem Ipsum has been the industry\'s standard dummy text'
      ' ever since the 1500s, when an unknown printer took a galley of type'
      ' and scrambled it to make a type specimen book.';

  static List<Product> products = [
    Product(
      name: 'Empanadas',
      price: 460,
      isAvailable: true,
      off: 300,
      quantity: 0,
      images: [
        'assets/images/empanadasdecarne.jpg',
        'assets/images/empanadasdecarne2.jpg',
        'assets/images/empanadasdecarne3.jpg',
      ],
      isFavorite: true,
      rating: 1,
      type: FoodType.all,
    ),
    Product(
      name: 'Bueñuelos',
      price: 380,
      isAvailable: false,
      off: 220,
      quantity: 0,
      images: [
        'assets/images/buñuelos2.jpg',
        'assets/images/buñuelos.png',
      ],
      isFavorite: false,
      rating: 4,
      type: FoodType.dessert,
    ),
    Product(
      name: 'Hayaca',
      price: 650,
      isAvailable: true,
      off: null,
      quantity: 0,
      images: [
        'assets/images/hayaca.jpg',
        'assets/images/hayaca2.jpeg',
      ],
      isFavorite: false,
      rating: 3,
      type: FoodType.salad,
    ),
    Product(
      name: 'Arroz calle',
      price: 229,
      isAvailable: true,
      off: 200,
      quantity: 0,
      images: [
        'assets/images/arrozcalle.jpg',
      ],
      isFavorite: false,
      rating: 5,
      sizes: ProductSizeType(
        categorical: [
          Categorical(CategoricalType.small, true),
          Categorical(CategoricalType.medium, false),
          Categorical(CategoricalType.large, false),
        ],
      ),
      type: FoodType.salad,
    ),
    Product(
      name: 'Perro pro',
      price: 330,
      isAvailable: true,
      off: null,
      quantity: 0,
      images: [
        'assets/images/perropro.jpg',
        'assets/images/perropro2.jpg',
      ],
      isFavorite: false,
      rating: 4,
      sizes: ProductSizeType(
        numerical: [
          Numerical('x2', true),
          Numerical('x4', false),
        ],
      ),
      type: FoodType.burger,
    ),
    Product(
      name: 'Salchipapa',
      price: 230,
      isAvailable: true,
      off: null,
      quantity: 0,
      images: [
        'assets/images/salchipapa.jpg',
        'assets/images/salchipapa2.jpeg',
      ],
      isFavorite: false,
      rating: 2,
      type: FoodType.all,
    ),
    Product(
      name: 'Deditos de queso',
      price: 497,
      isAvailable: true,
      off: null,
      quantity: 0,
      images: [
        'assets/images/deditosdequeso2.jpg',
        'assets/images/deditosdequeso.jpg',
      ],
      isFavorite: false,
      rating: 3,
      sizes: ProductSizeType(
        numerical: [
          Numerical('x43', true),
          Numerical('x50', false),
          Numerical('x55', false),
        ],
      ),
      type: FoodType.salad,
    ),
    Product(
      name: 'Pasa bocas combos',
      price: 498,
      isAvailable: true,
      off: null,
      quantity: 0,
      images: [
        'assets/images/combopasaboca1.jpg',
        'assets/images/combopasaboca2.jpg',
        'assets/images/combopasaboca3.jpg',
      ],
      isFavorite: false,
      sizes: ProductSizeType(
        numerical: [
          Numerical('1', true),
          Numerical('2', false),
          Numerical('3', false),
        ],
      ),
      rating: 2,
      type: FoodType.salad,
    ),
  ];

  static List<ProductCategory> categories = [
    ProductCategory(
      type: FoodType.all,
      icon: Icons.all_inclusive,
    ),
    ProductCategory(
      type: FoodType.pizza,
      icon: FontAwesomeIcons.pizzaSlice,
    ),
    ProductCategory(
      type: FoodType.burger,
      icon: FontAwesomeIcons.burger,
    ),
    ProductCategory(
      type: FoodType.sushi,
      icon: FontAwesomeIcons.bowlFood,
    ),
    ProductCategory(
      type: FoodType.salad,
      icon: Icons.local_pizza,
    ),
    ProductCategory(
      type: FoodType.dessert,
      icon: Icons.icecream,
    ),
  ];

  static List<Color> randomColors = [
    const Color(0xFFFCE4EC),
    const Color(0xFFF3E5F5),
    const Color(0xFFEDE7F6),
    const Color(0xFFE3F2FD),
    const Color(0xFFE0F2F1),
    const Color(0xFFF1F8E9),
    const Color(0xFFFFF8E1),
    const Color(0xFFECEFF1),
  ];

  static const Color lightOrangeColor = Color(0xFFEC6813);

  static List<BottomNavBarItem> bottomNavBarItems = [
    const BottomNavBarItem(
      "Inicio",
      Icon(Icons.home),
    ),
    const BottomNavBarItem(
      "Favoritos",
      Icon(Icons.favorite),
    ),
    const BottomNavBarItem(
      "Carrito",
      Icon(Icons.shopping_cart),
    ),
    const BottomNavBarItem(
      "Perfil",
      Icon(Icons.person),
    ),
  ];

  static List<RecommendedProduct> recommendedProducts = [
    RecommendedProduct(
      cardBackgroundColor: const Color(0xFFEC6813),
    ),
    RecommendedProduct(
      cardBackgroundColor: const Color(0xFF3081E1),
      buttonBackgroundColor: const Color(0xFF9C46FF),
      buttonTextColor: Colors.white,
    ),
  ];
}
