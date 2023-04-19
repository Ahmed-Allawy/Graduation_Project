import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/view/presentations/auth/cubit/auth_cubit.dart';
import 'package:graduation/view/presentations/home/home_screen.dart';
import 'package:graduation/view/shared/component/components.dart';

import '../../../shared/component/helperfunctions.dart';
import '../../../shared/component/layout.dart';
import '../../../shared/component/constants.dart';
import '../register/register_screen.dart';

class LoginHome extends StatefulWidget {
  const LoginHome({super.key});

  @override
  State<LoginHome> createState() => _LoginHomeState();
}

class _LoginHomeState extends State<LoginHome> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: SizedBox(
            height: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                //this is the key
                key: formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: double.infinity,
                      child: Image.asset(
                        'assets/images/3ef2582ea94414801edc3f61e80ee4c5.gif',
                        height: AppLayout.getHeigth(imageHeight),
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: AppLayout.getHeigth(space1),
                    ),
                    Text(
                      'Welcome',
                      style: TextStyle(
                          color: fontColor,
                          fontSize: AppLayout.getWidth(fontsize1)),
                    ),
                    SizedBox(
                      height: AppLayout.getHeigth(space2),
                    ),
                    defaultTextField(
                      controller: emailController,
                      textInputType: TextInputType.emailAddress,
                      prefix: Icons.email,
                      hintText: "Email",
                      validator: (val) {
                        return RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(val!)
                            ? null
                            : "Please enter a valid email";
                      },
                    ),
                    SizedBox(
                      height: AppLayout.getHeigth(space1),
                    ),
                    defaultTextField(
                        //here we send suffixIcon form the cubit
                        suffix: AuthCubit.get(context).suffixIcon,
                        suffixPressed: AuthCubit.get(context).changeScureity,
                        controller: passwordController,
                        textInputType: TextInputType.visiblePassword,
                        prefix: Icons.key,
                        hintText: "password",
                        //here we pass the bool from the cubit and the function on suffixpressed change the bool value every tap alson changing the icon
                        scure: AuthCubit.get(context).scuretiyPassword,
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Password shouldn't be empty";
                          }
                        }),
                    SizedBox(
                      height: AppLayout.getHeigth(space3),
                    ),
                    Text.rich(TextSpan(
                        text: "Forget Password",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: AppLayout.getWidth(fontsize2),
                            color: textColor),
                        recognizer: TapGestureRecognizer()..onTap = () {})),
                    SizedBox(
                      height: AppLayout.getHeigth(space4),
                    ),
                    defaultButton(
                      text: 'Log in',
                      onPressed: () {
                        // this is the build in validate function
                        //this function will check every TextFormField and compare the textcontroller.text to the valdator function and return the result
                        if (formKey.currentState!.validate()) {}
                      },
                    ),
                    SizedBox(
                      height: AppLayout.getHeigth(space4),
                    ),
                    Text.rich(TextSpan(
                        text: "you don't have an account? ",
                        style: TextStyle(
                            fontSize: AppLayout.getWidth(fontsize2),
                            color: fontColor),
                        children: <TextSpan>[
                          TextSpan(
                              text: "create one",
                              style: const TextStyle(
                                  color: textColor,
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  nextScreen(context, const Register());
                                })
                        ])),
                    SizedBox(
                      height: AppLayout.getHeigth(space0),
                    ),
                    Text.rich(TextSpan(
                        text: "or you can sign in as  ",
                        style: TextStyle(
                            fontSize: AppLayout.getWidth(fontsize2),
                            color: fontColor),
                        children: <TextSpan>[
                          TextSpan(
                              text: "Guest",
                              style: const TextStyle(
                                  color: textColor,
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  nextScreen(context, const HomeScreen());
                                })
                        ])),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}