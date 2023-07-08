// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:graduation/view/presentations/Searching_Screen/Searching_Screen.dart';
import 'package:graduation/view/presentations/Searching_Screen/cubit/search_cubit.dart';
import 'package:graduation/view/shared/component/helperfunctions.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../shared/component/components.dart';
import '../../shared/network/local/cach_helper.dart';

// ignore: must_be_immutable
class SecondSearchingScreen extends StatelessWidget {
  final int people;
  const SecondSearchingScreen({
    Key? key,
    required this.people,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKeys = List<GlobalKey<FormState>>.generate(
      people,
      (index) => GlobalKey<FormState>(),
    );

    var firstNameControllers = List<TextEditingController>.generate(
        people, (index) => TextEditingController());
    var lastNameControllers = List<TextEditingController>.generate(
        people, (index) => TextEditingController());
    var passportControllers = List<TextEditingController>.generate(
        people, (index) => TextEditingController());
    var nationalityControllers = List<TextEditingController>.generate(
        people, (index) => TextEditingController());
    var emailControllers = List<TextEditingController>.generate(
        people, (index) => TextEditingController());
    var passwordControllers = List<TextEditingController>.generate(
        people, (index) => TextEditingController());
    var ageControllers = List<TextEditingController>.generate(
        people, (index) => TextEditingController());
    var genderControllers = List<TextEditingController>.generate(
        people, (index) => TextEditingController());
    var phoneNumberControllers = List<TextEditingController>.generate(
        people, (index) => TextEditingController());

    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 105, 116, 235),
            centerTitle: true,
            title: const Text("Adding the passenger"),
            leading: BackButton(
              onPressed: () => nextScreenRep(
                  context,
                  SearchingScreen(
                    isloged: CacheHelper.getData(key: 'isLoged'),
                  )),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(25),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: people,
                    itemBuilder: (context, index) {
                      return Form(
                        key: formKeys[index],
                        child: Column(
                          children: [
                            defaultTextField(
                              width: double.infinity,
                              prefix: Icons.person,
                              controller: firstNameControllers[index],
                              textInputType: TextInputType.name,
                              hintText: "First Name",
                              validator: (val) {
                                if (val.isEmpty) {
                                  return "First Name shouldn't be empty";
                                }
                              },
                            ),
                            const Gap(25),
                            defaultTextField(
                              width: double.infinity,
                              prefix: Icons.person,
                              controller: lastNameControllers[index],
                              textInputType: TextInputType.name,
                              hintText: "LastName",
                              validator: (val) {
                                if (val.isEmpty) {
                                  return "Last Name shouldn't be empty";
                                }
                              },
                            ),
                            const Gap(25),
                            defaultTextField(
                              width: double.infinity,
                              prefix: Icons.numbers,
                              controller: passportControllers[index],
                              textInputType: TextInputType.number,
                              hintText: "Passport",
                              validator: (val) {
                                if (val.isEmpty) {
                                  return "Passport shouldn't be empty";
                                }
                              },
                            ),
                            const Gap(25),
                            defaultTextField(
                              width: double.infinity,
                              prefix: Icons.flag,
                              controller: nationalityControllers[index],
                              textInputType: TextInputType.name,
                              hintText: "Nationality",
                              validator: (val) {
                                if (val.isEmpty) {
                                  return "Nationality shouldn't be empty";
                                }
                              },
                            ),
                            const Gap(25),
                            defaultTextField(
                              width: double.infinity,
                              controller: emailControllers[index],
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
                            const Gap(25),
                            defaultTextField(
                              width: double.infinity,
                              prefix: Icons.visibility,
                              controller: passwordControllers[index],
                              textInputType: TextInputType.name,
                              hintText: "password",
                              validator: (val) {
                                if (val.isEmpty) {
                                  return "Password shouldn't be empty";
                                }
                              },
                            ),
                            const Gap(25),
                            SizedBox(
                              width: double.infinity,
                              child: IntlPhoneField(
                                controller: phoneNumberControllers[index],
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(),
                                  ),
                                ),
                                onChanged: (s) {},
                                initialCountryCode: 'EG',
                              ),
                            ),
                            defaultTextField(
                              width: double.infinity,
                              prefix: Icons.date_range,
                              controller: ageControllers[index],
                              textInputType: TextInputType.number,
                              hintText: "AGE",
                              validator: (val) {
                                if (val.isEmpty) {
                                  return "AGE shouldn't be empty";
                                }
                              },
                            ),
                            const Gap(25),
                            defaultTextField(
                              width: double.infinity,
                              prefix: Icons.male,
                              controller: genderControllers[index],
                              textInputType: TextInputType.name,
                              hintText: "Gender",
                              validator: (val) {
                                if (val.isEmpty) {
                                  return "Gender should be either male or female";
                                }
                              },
                            ),
                            const Gap(25),
                            const SizedBox(
                              height: 24,
                              child: DotedWidget(
                                color: Color.fromARGB(255, 67, 79, 210),
                                section: 10,
                                width: 4,
                              ),
                            ),
                            const Gap(25),
                          ],
                        ),
                      );
                    },
                  ),
                  const Gap(25),
                  defaultButton(
                    text: "Submit",
                    onPressed: () {
                      for (var form in formKeys) {
                        if (form.currentState!.validate()) {
                          print(formKeys.length);
                        } else {
                          print(formKeys);
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
