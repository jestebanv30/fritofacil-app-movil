import 'package:fritofacil/src/model/product_size_type.dart';

enum FoodType { all, pizza, burger, sushi, salad, dessert }

class Product {
  String name;
  int price;
  int? off;
  String about;
  bool isAvailable;
  ProductSizeType? sizes;
  int _quantity;
  String imageUrl;
  bool isFavorite;
  double rating;
  FoodType type;

  int get quantity => _quantity;

  set quantity(int newQuantity) {
    if (newQuantity >= 0) _quantity = newQuantity;
  }

  Product(
      {this.sizes,
      required this.about,
      required this.name,
      required this.price,
      required this.isAvailable,
      required this.off,
      required int quantity,
      required this.imageUrl,
      required this.isFavorite,
      required this.rating,
      required this.type})
      : _quantity = quantity;
}
