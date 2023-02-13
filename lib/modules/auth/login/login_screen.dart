import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/modules/auth/cubit/auth_cubit.dart';
import 'package:graduation/shared/component/components.dart';

import '../../../shared/component/layout.dart';
import '../../../shared/component/constants.dart';

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
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: backGroundColor,
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
                          controller: passwordController,
                          textInputType: TextInputType.visiblePassword,
                          prefix: Icons.password,
                          hintText: "password",
                          scure: true,
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
                              fontSize: AppLayout.getWidth(fieldFontSize),
                              color: fontColor),
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
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
