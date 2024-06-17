import 'package:flutter/material.dart' show IconData;
import 'package:fritofacil/src/model/product.dart';

class ProductCategory {
  FoodType type;
  bool isSelected;
  IconData icon;

  ProductCategory({
    required this.type,
    this.isSelected = false,
    required this.icon,
  });
}
