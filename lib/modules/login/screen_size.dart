import 'package:flutter/material.dart';

class ScreenSize {
  BuildContext context;

  ScreenSize(this.context);

  getSize() {
    return MediaQuery.of(context).size;
  }

  getScreenHeight() {
    return getSize().height;
  }

  getScreenWidth() {
    return getSize().width;
  }

  getHeigth(double pixels) {
    return getScreenHeight() * pixels / 844;
  }

  getWidth(double pixels) {
    return getScreenWidth() * pixels / 390;
  }
}
