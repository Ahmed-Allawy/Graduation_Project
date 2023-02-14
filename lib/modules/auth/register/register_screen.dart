import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/modules/auth/cubit/auth_cubit.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../shared/component/components.dart';
import '../../../shared/component/constants.dart';
import '../../../shared/component/layout.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late DateTime dateTime;
  String? phoneNumber;
  final faceImageController = TextEditingController();

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
                              child: Center(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        height: AppLayout.getHeigth(space5),
                                      ),
                                      Text(
                                        'Register',
                                        style: TextStyle(
                                            color: fontColor,
                                            fontSize:
                                                AppLayout.getWidth(fontsize1)),
                                      ),
                                      SizedBox(
                                        height: AppLayout.getHeigth(space6),
                                      ),
                                      defaultTextField(
                                        controller: firstNameController,
                                        textInputType: TextInputType.name,
                                        hintText: "First Name",
                                        validator: (val) {
                                          if (val.isEmpty) {
                                            return "First Name shouldn't be empty";
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        height: AppLayout.getHeigth(space1),
                                      ),
                                      defaultTextField(
                                        controller: lastNameController,
                                        textInputType: TextInputType.name,
                                        hintText: "Last Name",
                                        validator: (val) {
                                          if (val.isEmpty) {
                                            return "Last Name shouldn't be empty";
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        height: AppLayout.getHeigth(space1),
                                      ),
                                      defaultTextField(
                                        controller: emailController,
                                        textInputType:
                                            TextInputType.emailAddress,
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
                                          textInputType:
                                              TextInputType.visiblePassword,
                                          prefix: Icons.password,
                                          hintText: "password",
                                          scure: true,
                                          validator: (val) {
                                            if (val.isEmpty) {
                                              return "Password shouldn't be empty";
                                            }
                                          }),
                                      SizedBox(
                                        height: AppLayout.getHeigth(space1),
                                      ),
                                      defaultButton(
                                          text: "select your date",
                                          onPressed: () {
                                            showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(1800),
                                                    lastDate: DateTime(3000))
                                                .then((value) =>
                                                    dateTime = value!);
                                          }),
                                      SizedBox(
                                        height: AppLayout.getHeigth(space1),
                                      ),
                                      Container(
                                        color: fontColor,
                                        width: AppLayout.getWidth(fieldWidth),
                                        child: IntlPhoneField(
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(),
                                            ),
                                          ),
                                          onChanged: (value) => phoneNumber =
                                              value.completeNumber,
                                          initialCountryCode: 'EG',
                                        ),
                                      ),

                                      SizedBox(
                                        height: AppLayout.getHeigth(space1),
                                      ),
                                      defaultTextField(
                                          controller: faceImageController,
                                          textInputType: TextInputType.none,
                                          prefix: Icons.face,
                                          hintText: "Face Image",
                                          scure: true,
                                          validator: (val) {
                                            if (val.isEmpty) {
                                              return "Please take an image";
                                            }
                                          }),
                                      SizedBox(
                                        height: AppLayout.getHeigth(space2),
                                      ),
                                      defaultButton(
                                          text: 'Create Account',
                                          onPressed: () {
                                            if (formKey.currentState!
                                                .validate()) {}
                                            // print(phoneNumber);
                                          }),
                                      SizedBox(
                                        height: AppLayout.getHeigth(space3),
                                      ),
                                      defaultButton(
                                          text: 'Continue with Google',
                                          onPressed: () {}),
                                      SizedBox(
                                        height: AppLayout.getHeigth(space3),
                                      ),
                                      defaultButton(
                                          text: 'Continue with Apple',
                                          onPressed: () {}),
                                      SizedBox(
                                        height: AppLayout.getHeigth(space3),
                                      ),
                                      // Text.rich(TextSpan(
                                      //     text:
                                      //         "Already have an account? Sign in",
                                      //     style: TextStyle(
                                      //         decoration:
                                      //             TextDecoration.underline,
                                      //         fontSize: AppLayout.getWidth(
                                      //             fieldFontSize),
                                      //         color: fontColor),
                                      //     recognizer: TapGestureRecognizer()
                                      //       ..onTap = () {
                                      //         nextScreen(
                                      //             context, const LoginHome());
                                      //       })),
                                      // SizedBox(
                                      //   height: AppLayout.getHeigth(space3),
                                      // ),
                                    ]),
                              )))));
            }));
  }
}
