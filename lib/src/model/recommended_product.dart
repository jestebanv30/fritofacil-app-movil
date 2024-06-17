import 'package:flutter/material.dart' show Color, Colors;
import 'package:fritofacil/core/app_color.dart';

class RecommendedProduct {
  Color? cardBackgroundColor;
  Color? buttonTextColor;
  Color? buttonBackgroundColor;
  String imagePath;

  RecommendedProduct({
    this.cardBackgroundColor,
    this.buttonTextColor = AppColor.darkOrange,
    this.buttonBackgroundColor = Colors.white,
    this.imagePath = "assets/images/señora2.jpg",
  });
}
