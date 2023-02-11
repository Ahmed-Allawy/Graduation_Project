// ignore_for_file: avoid_print, unused_local_variable, prefer_typing_uninitialized_variables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:graduation/modules/login/login_data.dart';
import 'package:graduation/modules/login/screen_size.dart';

import '../constants.dart';

class LoginHome extends StatefulWidget {
  const LoginHome({super.key});

  @override
  State<LoginHome> createState() => _LoginHomeState();
}

class _LoginHomeState extends State<LoginHome> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ScreenSize screenSize = ScreenSize(context);

    return Scaffold(
      backgroundColor: backGroundColor,
      body: SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                child: Image.asset(
                  'assets/images/3ef2582ea94414801edc3f61e80ee4c5.gif',
                  height: screenSize.getHeigth(imageHeight),
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: screenSize.getHeigth(space1),
              ),
              Text(
                'Welcome',
                style: TextStyle(
                    color: fontColor, fontSize: screenSize.getWidth(fontsize1)),
              ),
              SizedBox(
                height: screenSize.getHeigth(space2),
              ),
              Email(
                screenSize: screenSize,
                emailController: emailController,
              ),
              SizedBox(
                height: screenSize.getHeigth(space1),
              ),
              Password(
                screenSize: screenSize,
                passwordController: passwordController,
              ),
              SizedBox(
                height: screenSize.getHeigth(space3),
              ),
              ForgetField(screenSize: screenSize),
              SizedBox(
                height: screenSize.getHeigth(space4),
              ),
              LogInButton(
                  screenSize: screenSize,
                  passwordController: passwordController,
                  emailController: emailController)
            ],
          ),
        ),
      ),
    );
  }
}

class ForgetField extends StatelessWidget {
  const ForgetField({
    super.key,
    required this.screenSize,
  });

  final ScreenSize screenSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenSize.getWidth(fieldWidth),
      alignment: Alignment.topRight,
      child: GestureDetector(
        onTap: () {
          print("forgot password");
        },
        child: Text(
          'Forgot password?',
          style: TextStyle(
              color: fontColor, fontSize: screenSize.getWidth(fieldFontSize)),
        ),
      ),
    );
  }
}

class Password extends StatelessWidget {
  const Password({
    super.key,
    required this.screenSize,
    required this.passwordController,
  });

  final ScreenSize screenSize;
  final passwordController;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenSize.getWidth(fieldWidth),
      decoration: const BoxDecoration(
          color: fontColor, borderRadius: BorderRadius.all(Radius.circular(5))),
      child: TextField(
          controller: passwordController,
          decoration: const InputDecoration(
            icon: Icon(Icons.key_sharp),
            hintText: 'Password',
            hintStyle: TextStyle(color: hintColor),
            iconColor: fieldIconColor,
          )),
    );
  }
}

class Email extends StatelessWidget {
  const Email({
    super.key,
    required this.screenSize,
    required this.emailController,
  });

  final ScreenSize screenSize;
  final emailController;
  @override
  Widget build(BuildContext context) {
    // bool isValid = false;
    return Container(
      width: screenSize.getWidth(fieldWidth),
      decoration: const BoxDecoration(
          color: fontColor, borderRadius: BorderRadius.all(Radius.circular(5))),
      child: TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            icon: Icon(Icons.personal_injury_rounded),
            hintText: 'Email',
            hintStyle: TextStyle(color: hintColor),
            iconColor: fieldIconColor,
          )),
    );
  }
}

class LogInButton extends StatelessWidget {
  LogInButton({
    super.key,
    required this.screenSize,
    required this.passwordController,
    required this.emailController,
  });

  final ScreenSize screenSize;
  final passwordController;
  final emailController;
  LogInData logInData = LogInData();
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: screenSize.getWidth(fieldWidth),
      height: screenSize.getHeigth(logInButtonHeight),
      color: logInButtonColor,
      onPressed: () {
        logInData.setEmailValue(emailController.text.toString());
        logInData.setPasswordValue(passwordController.text.toString());
        // print(logInData.isValid());
        if (!logInData.isValid()) {
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              backgroundColor: backGroundColor,
              title: Text('Email not valid',
                  style: TextStyle(
                      color: fontColor,
                      fontSize: screenSize.getWidth(fieldFontSize))),
              content: Text(
                'please enter valid email',
                style: TextStyle(
                    color: fontColor,
                    fontSize: screenSize.getWidth(fieldFontSize)),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: Text(
                    'OK',
                    style: TextStyle(
                        color: fontColor,
                        fontSize: screenSize.getWidth(fieldFontSize)),
                  ),
                ),
              ],
            ),
          );
          const Text('Show Dialog');
        }
      },
      child: Text(
        "Log in",
        style: TextStyle(fontSize: screenSize.getWidth(logInButtonFontSize)),
      ),
    );
  }
}
