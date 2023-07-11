// ignore_for_file: file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:graduation/view/presentations/Searching_Screen/Searching_Screen.dart';
import 'package:graduation/view/presentations/Searching_Screen/cubit/search_cubit.dart';
import 'package:graduation/view/presentations/Seat_screen/select_seat.dart';
import 'package:graduation/view/shared/component/helperfunctions.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../shared/component/components.dart';
import '../../shared/component/constants.dart';
import '../../shared/network/local/cach_helper.dart';

// ignore: must_be_immutable
class SecondSearchingScreen extends StatelessWidget {
  int people;
  SecondSearchingScreen({
    Key? key,
    required this.people,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKeys = List<GlobalKey<FormState>>.generate(
      people,
      (index) => GlobalKey<FormState>(),
    );
    if (CacheHelper.getData(key: "isloged")) {
      people--;
    }

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

    List<String> userIds = [];

    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (CacheHelper.getData(key: "isloged")) {
          userIds.add(CacheHelper.getData(key: "Mainusertoken"));
        }
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
                                final alphaRegex = RegExp(r'^[a-zA-Z]+$');
                                if (alphaRegex.hasMatch(val)) {
                                } else {
                                  return "the name should have only latter";
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
                                  return "First Name shouldn't be empty";
                                }
                                final alphaRegex = RegExp(r'^[a-zA-Z]+$');
                                if (alphaRegex.hasMatch(val)) {
                                } else {
                                  return "the name should have only latter";
                                }
                              },
                            ),
                            const Gap(25),
                            defaultTextField(
                              width: double.infinity,
                              prefix: Icons.numbers,
                              controller: passportControllers[index],
                              textInputType: TextInputType.name,
                              hintText: "Passport number ",
                              validator: (val) {
                                if (val.isEmpty) {
                                  return "Passport shouldn't be empty";
                                }
                                final hasNumbers = RegExp(r'\d').hasMatch(val);
                                final hasCapitalLetters =
                                    RegExp(r'[A-Z]').hasMatch(val);

                                if (!hasNumbers ||
                                    !hasCapitalLetters ||
                                    val.length != 9) {
                                  return 'Passport number must be like this ABA9875413';
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
                                int? age = int.tryParse(val);
                                if (age! > 100 || age < 12) {
                                  return "please enter a vaild Age";
                                }
                              },
                            ),
                            const Gap(25),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              width: double.infinity,
                              child: DropdownButton(
                                  autofocus: true,
                                  focusColor: Colors.white,
                                  dropdownColor: Colors.white,
                                  hint: Text(
                                    SearchCubit.get(context).country[index],
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  items: countryList
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (s) {
                                    nationalityControllers[index].text = s!;
                                    return SearchCubit.get(context)
                                        .changeCountrey(s, index);
                                  }),
                            ),
                            const Gap(25),
                            Row(
                              children: [
                                Expanded(
                                  child: RadioListTile(
                                      title: const Text('Male'),
                                      value: true,
                                      groupValue: SearchCubit.get(context)
                                          .gender[index],
                                      activeColor: const Color.fromARGB(
                                          255, 105, 116, 235),
                                      onChanged: (val) {
                                        SearchCubit.get(context)
                                            .changeGender(val, index);
                                        if (SearchCubit.get(context)
                                            .gender[index]) {
                                          genderControllers[index].text =
                                              "Male";
                                        } else {
                                          genderControllers[index].text =
                                              "Female";
                                        }
                                      }),
                                ),
                                Expanded(
                                  child: RadioListTile(
                                      title: const Text('Female'),
                                      value: false,
                                      groupValue: SearchCubit.get(context)
                                          .gender[index],
                                      activeColor: const Color.fromARGB(
                                          255, 105, 116, 235),
                                      onChanged: (val) {
                                        SearchCubit.get(context)
                                            .changeGender(val, index);
                                        if (SearchCubit.get(context)
                                            .gender[index]) {
                                          genderControllers[index].text =
                                              "Male";
                                        } else {
                                          genderControllers[index].text =
                                              "Female";
                                        }
                                      }),
                                )
                              ],
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
                    text: "Sumbit",
                    onPressed: () {
                      for (var form in formKeys) {
                        if (form.currentState!.validate()) {
                          SearchCubit.get(context).sumbit(
                              context,
                              people,
                              firstNameControllers,
                              lastNameControllers,
                              passportControllers,
                              nationalityControllers,
                              emailControllers,
                              passwordControllers,
                              phoneNumberControllers,
                              ageControllers,
                              genderControllers);

                          SearchCubit.get(context).sendClients().then((value) {
                            print(value);
                            userIds.addAll(value);
                            if (value.isNotEmpty) {
                              nextScreen(
                                  context,
                                  SelectSeat(
                                    usersID: userIds,
                                  ));
                              // nextScreen(
                              //     context,
                              //     PicScreen(
                              //         token: value,
                              //         firstnames: firstNameControllers));
                              SearchCubit.get(context).clearPersons();
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Failed'),
                                  content: const Text(
                                      'Invalid user information\n[email, password, passport].\n\t\t\t\tPlease try again.'),
                                  actions: [
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ],
                                ),
                              );
                            }
                            SearchCubit.get(context).clearPersons();
                          });
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
