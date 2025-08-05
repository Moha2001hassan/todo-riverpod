import 'package:flutter/material.dart';

class SizeConfig {
  static double screenWidth = 0.0;
  static double screenHeight = 0.0;

  static void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }

  static double getProportionateScreenHeight(double inputHeight) {
    return (inputHeight / 812.0) * screenHeight;
  }

  static double getProportionateScreenWidth(double inputWidth) {
    return (inputWidth / 375.0) * screenWidth;
  }
}
