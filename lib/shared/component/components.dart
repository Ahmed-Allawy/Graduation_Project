// ignore_for_file: void_checks

import 'package:flutter/material.dart';

import 'constants.dart';
import 'layout.dart';

// this widget will use it for all the pages that contains fields
Widget defaultTextField({
  required TextEditingController controller,
  required TextInputType textInputType,
  IconData? prefix,
  required String hintText,
  required Function validator,
  //this bool not required because I will use it only one time
  bool scure = false,
}) {
  return Container(
    width: AppLayout.getWidth(fieldWidth),
    decoration: const BoxDecoration(
        color: fontColor, borderRadius: BorderRadius.all(Radius.circular(5))),
    child: TextFormField(
        validator: (value) {
          return validator(value);
        },
        controller: controller,
        obscureText: scure,
        keyboardType: textInputType,
        decoration: InputDecoration(
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: errorColor)),
          prefixIcon: Icon(prefix),
          hintText: hintText,
          hintStyle: const TextStyle(color: hintColor),
          iconColor: fieldIconColor,
        )),
  );
}

Widget defaultButton({
  required String text,
  required Function onPressed,
}) {
  return MaterialButton(
    minWidth: AppLayout.getWidth(fieldWidth),
    height: AppLayout.getHeigth(logInButtonHeight),
    color: logInButtonColor,
    onPressed: () {
      return onPressed();
    },
    child: Text(
      text,
      style: TextStyle(
          fontSize: AppLayout.getWidth(logInButtonFontSize), color: fontColor),
    ),
  );
}
