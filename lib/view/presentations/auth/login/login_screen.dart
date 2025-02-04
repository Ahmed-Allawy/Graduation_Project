// ignore_for_file: depend_on_referenced_packages, await_only_futures

import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:graduation/view/presentations/Searching_Screen/Searching_Screen.dart';
import 'package:graduation/view/presentations/auth/cubit/auth_cubit.dart';
import 'package:graduation/view/shared/component/components.dart';
import 'package:http/http.dart' as http;
import '../../../shared/component/helperfunctions.dart';
import '../../../shared/component/layout.dart';
import '../../../shared/component/constants.dart';
import '../../../shared/network/local/cach_helper.dart';
import '../../Searching_Screen/cubit/search_cubit.dart';
import '../register/register_screen.dart';

class LoginHome extends StatefulWidget {
  const LoginHome({super.key});

  @override
  State<LoginHome> createState() => _LoginHomeState();
}

class _LoginHomeState extends State<LoginHome> {
  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // CacheHelper.init();
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Styles.blueColor,
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: Image.asset(
                      'assets/images/3ef2582ea94414801edc3f61e80ee4c5.gif',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Form(
                      key: formKey,
                      child: Column(
                        children: <Widget>[
                          const Gap(10),
                          Text(
                            'Welcome',
                            style: Styles.headLinestyle0,
                          ),
                          const Gap(50),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: defaultTextField(
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
                          ),
                          const Gap(20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: defaultTextField(
                                //here we send suffixIcon form the cubit
                                suffix: AuthCubit.get(context).suffixIcon,
                                suffixPressed:
                                    AuthCubit.get(context).changeScureity,
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
                          ),
                          const Gap(20),
                          Text.rich(TextSpan(
                              text: "Forget Password",
                              style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 17,
                                  color: textColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {})),
                          const Gap(20),
                          defaultButton(
                            text: 'Log in',
                            onPressed: () {
                              // this is the build in validate function
                              //this function will check every TextFormField and compare the textcontroller.text to the valdator function and return the result
                              if (formKey.currentState!.validate()) {
                                login(emailController.text,
                                        passwordController.text)
                                    .then((value) {
                                  if (value) {
                                    SearchCubit.get(context)
                                        .fetchAirports()
                                        .then((value) {
                                      SearchCubit.get(context).countries =
                                          value;
                                      CacheHelper.saveData(
                                          key: 'isLoged', value: true);
                                      nextScreen(
                                          context,
                                          SearchingScreen(
                                            isloged: CacheHelper.getData(
                                                key: 'isLoged'),
                                          ));
                                    });
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Login Failed'),
                                        content: const Text(
                                            'Invalid email or password. Please try again.'),
                                        actions: [
                                          TextButton(
                                            child: const Text('OK'),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                });
                              }
                            },
                          ),
                          const Gap(20),
                          Text.rich(TextSpan(
                              text: "you don't have an account? ",
                              style: const TextStyle(
                                  fontSize: fontsize2, color: fontColor),
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
                          const Gap(10),
                          Text.rich(TextSpan(
                              text: "or you can sign in as  ",
                              style: const TextStyle(
                                  fontSize: fontsize2, color: fontColor),
                              children: <TextSpan>[
                                TextSpan(
                                    text: "Guest",
                                    style: const TextStyle(
                                        color: textColor,
                                        decoration: TextDecoration.underline),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        //user not login
                                        CacheHelper.saveData(
                                            key: 'isLoged', value: false);
                                        //get airports data
                                        SearchCubit.get(context)
                                            .fetchAirports()
                                            .then((value) {
                                          SearchCubit.get(context).countries =
                                              value;

                                          nextScreen(
                                              context,
                                              SearchingScreen(
                                                isloged: CacheHelper.getData(
                                                    key: 'isLoged'),
                                              ));
                                        });
                                      })
                              ])),
                          const Gap(10),
                        ],
                      ))
                ],
              ),
            ));
      },
    );
  }
}

Future<bool> login(emial, pass) async {
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request('POST', Uri.parse('${uri}api/login'));
  //here I send the password and the phone number for login by passing them to the body
  request.body = json.encode({"password": pass, "email": emial});
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  // Check the status code and decode the response body
  if (response.statusCode == 200) {
    // Read the response body as a string
    String token = await response.headers["x-auth-token"]!;
    // Save the token to shared preferences or some other storage
    CacheHelper.saveData(key: 'mainUserToken', value: token);

    return true;
  } else if (response.statusCode == 400) {
    return false;
  } else {
    return false;
  }
}
