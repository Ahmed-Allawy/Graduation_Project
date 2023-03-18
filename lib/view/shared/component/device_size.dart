import 'package:flutter/cupertino.dart';

class LayoutSize {
  static double? screenWigth;
  static double? screenHeight;
  static double? layoutValue;
  static Orientation? orientation;

  void init(BuildContext context) {
    screenWigth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    layoutValue = orientation == Orientation.landscape
        ? screenHeight! * 0.024
        : screenWigth! * 0.024;
  }
}
