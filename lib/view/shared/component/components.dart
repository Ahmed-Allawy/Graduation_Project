// ignore_for_file: void_checks

import 'package:flutter/material.dart';

import 'constants.dart';
import 'layout.dart';

// this widget will use it for all the pages that contains fields
Widget defaultTextField({
  required TextEditingController controller,
  required TextInputType textInputType,
  IconData? prefix,
  IconData? suffix,
  required String hintText,
  required Function validator,
  Function? suffixPressed,
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
          prefixIcon: Icon(
            prefix,
            color: primarycolor,
          ),
          //here we will check if the suffixpressed is avaiable or not then pass it if it's avaiable
          suffixIcon: IconButton(
            icon: Icon(
              suffix,
              color: primarycolor,
            ),
            onPressed: () {
              suffixPressed!();
            },
          ),
          hintText: hintText,
          hintStyle: const TextStyle(color: hintColor),
          iconColor: fieldIconColor,
        )),
  );
}

Widget defaultButton({
  required String text,
  required Function onPressed,
  double circularRaduis = 20,
}) {
  return MaterialButton(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(circularRaduis),
    ),
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

Widget defaultTextButton({
  required String text,
  required Function onpressed,
}) {
  return TextButton(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all<TextStyle>(
            const TextStyle(color: errorColor)),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.all(space0)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(space1),
            side: const BorderSide(color: errorColor),
          ),
        ),
      ),
      onPressed: () {
        return onpressed();
      },
      child: Text(text));
}

//this widget to show Snackbar if error happend and can used anywhere
void showSnackbar(context, message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: message,
    backgroundColor: Theme.of(context).primaryColor,
    duration: const Duration(seconds: 5),
    action: SnackBarAction(label: "ok", onPressed: (() {})),
  ));
}
