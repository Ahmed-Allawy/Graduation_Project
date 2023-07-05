// ignore_for_file: use_build_context_synchronously, avoid_print, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/view/presentations/auth/cubit/auth_cubit.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../model/userdata.dart';
import '../../../shared/component/components.dart';
import '../../../shared/component/constants.dart';
import '../../../shared/component/helperfunctions.dart';
import '../../../shared/component/layout.dart';
import '../../Searching_Screen/Searching_Screen.dart';
import 'package:http/http.dart' as http;

import '../../Searching_Screen/cubit/search_cubit.dart';

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
  // late DateTime dateTime;
  String phoneNumber = '0';

  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    User user = User(
        country: 'Egypt',
        email: emailController.text,
        fname: firstNameController.text,
        lname: lastNameController.text,
        password: passwordController.text,
        phone: phoneNumber);
    return BlocConsumer<AuthCubit, AuthState>(
        //here I am going to listen the changes that happened
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
                                    prefix: Icons.person,
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
                                    prefix: Icons.people,
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
                                      suffixPressed:
                                          AuthCubit.get(context).changeScureity,
                                      controller: passwordController,
                                      textInputType:
                                          TextInputType.visiblePassword,
                                      prefix: Icons.key,
                                      hintText: "password",
                                      //here we pass the bool from the cubit and the function on suffixpressed change the bool value every tap alson changing the icon
                                      scure: AuthCubit.get(context)
                                          .scuretiyPassword,
                                      validator: (val) {
                                        if (val.isEmpty) {
                                          return "Password shouldn't be empty";
                                        }
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
                                      onChanged: (value) =>
                                          phoneNumber = value.completeNumber,
                                      initialCountryCode: 'EG',
                                    ),
                                  ),
                                  SizedBox(
                                    height: AppLayout.getHeigth(space1),
                                  ),
                                  SizedBox(
                                    height: AppLayout.getHeigth(space2),
                                  ),
                                  defaultButton(
                                      text: 'Create Account',
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          print(phoneNumber);
                                          signup(user, context);
                                        }
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
                                ]),
                          )))));
        });
  }
}

signup(User user, BuildContext context) async {
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request('POST', Uri.parse('${uri}api/user'));
  request.body = user.toJson();
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(response);
    SearchCubit.get(context).fetchAirports().then((value) {
      SearchCubit.get(context).countries = value;

      nextScreen(
          context,
          SearchingScreen(
            isloged: false,
          ));
    });
  } else {
    print('failed $response');
  }
}
