// ignore_for_file: must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:graduation/modules/auth/login/login_screen.dart';
import 'package:graduation/modules/auth/register/register_screen.dart';

import '../../shared/component/components.dart';
import '../../shared/component/constants.dart';
import '../../shared/component/helperfunctions.dart';
import '../../shared/component/layout.dart';

class HomeScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        color: Colors.red,
        child: Image.asset(
          'assets/images/3ef2582ea94414801edc3f61e80ee4c5.gif',
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
      ),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            defaultButton(
                text: "Log in",
                onPressed: () {
                  nextScreen(context, const LoginHome());
                }),
            SizedBox(
              height: AppLayout.getHeigth(space2),
            ),
            defaultButton(
                text: "Register",
                onPressed: () {
                  nextScreen(context, const Register());
                }),
            SizedBox(
              height: AppLayout.getHeigth(space2),
            ),
            defaultButton(text: "Guest", onPressed: () {}),
          ],
        ),
      )
    ]);
  }
}
