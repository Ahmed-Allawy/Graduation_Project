// ignore_for_file: public_member_api_docs, sort_constructors_first, depend_on_referenced_packages, unnecessary_brace_in_string_interps, iterable_contains_unrelated_type, avoid_print
// ignore_for_file: file_names

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:graduation/view/presentations/My_Trips/my_trips.dart';

import 'package:graduation/view/presentations/Searching_Screen/cubit/search_cubit.dart';
import 'package:graduation/view/presentations/User_profile/user_profile.dart';
import 'package:graduation/view/presentations/auth/login/login_screen.dart';
import 'package:graduation/view/presentations/auth/register/register_screen.dart';
import 'package:graduation/view/presentations/find_ticket/find_tickt.dart';
import 'package:graduation/view/shared/component/constants.dart';
import 'package:graduation/view/shared/component/helperfunctions.dart';
import 'package:graduation/view/shared/network/local/cach_helper.dart';

import '../../../model/airports.dart';
import '../../../model/flight.dart';
import '../../shared/component/components.dart';
import '../../shared/component/layout.dart';

// ignore: must_be_immutable
class SearchingScreen extends StatelessWidget {
  final GlobalKey<AutoCompleteTextFieldState<Airport>> arrivalCompleteKey =
      GlobalKey();

  final TextEditingController arrivaltextEditingController =
      TextEditingController();

  final GlobalKey<AutoCompleteTextFieldState<Airport>> deupartureCompleteKey =
      GlobalKey();

  final TextEditingController deupartureEditingController =
      TextEditingController();

  final TextEditingController adultEditingController = TextEditingController();

  final TextEditingController childEditingController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  DateTime? selectedDate;
  final bool isloged;
  SearchingScreen({
    Key? key,
    this.selectedDate,
    required this.isloged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SearchCubit.get(context);
        return Scaffold(
          backgroundColor: Styles.bgColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: formKey,
                  child: SizedBox(
                    child: ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                          horizontal: AppLayout.getWidth(20),
                          vertical: AppLayout.getHeigth(40)),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "What are \nyou looking for?",
                              style: Styles.headLinestyle1,
                            ),
                            IconButton(
                                onPressed: () {
                                  _showOptionsModal(context, isloged);
                                },
                                icon: const Icon(Icons.info))
                          ],
                        ),
                        Gap(AppLayout.getHeigth(25)),
                        Gap(AppLayout.getHeigth(25)),
                        CustomTextFieldSearch(
                          hint: "Departure",
                          autoCompleteKey: deupartureCompleteKey,
                          textEditingController: deupartureEditingController,
                          selectedCountry: deupartureEditingController.text,
                          countries: SearchCubit.get(context).countries,
                          sumbit: (item) {},
                          build: (context, item) {
                            return ListTile(
                              title: AirPortInfo(
                                airportData: item,
                              ),
                              onTap: () {
                                print("svsdgsdsds");
                                SearchCubit.get(context).sumbitCountery(
                                    item, deupartureEditingController);
                              },
                            );
                          },
                        ),
                        Gap(AppLayout.getHeigth(15)),
                        CustomTextFieldSearch(
                          hint: "Arrival",
                          autoCompleteKey: arrivalCompleteKey,
                          textEditingController: arrivaltextEditingController,
                          selectedCountry: arrivaltextEditingController.text,
                          countries: SearchCubit.get(context).countries,
                          sumbit: (item) {},
                          build: (context, item) {
                            return ListTile(
                              title: AirPortInfo(
                                airportData: item,
                              ),
                              onTap: () {
                                print("dgfggdgdfgggdsddsfsdfdsfdsf");
                                SearchCubit.get(context).sumbitCountery(
                                    item, arrivaltextEditingController);
                              },
                            );
                          },
                        ),
                        Gap(AppLayout.getHeigth(25)),
                        Row(
                          children: [
                            Expanded(
                              child: RadioListTile(
                                  title: const Text('One way'),
                                  value: true,
                                  groupValue: SearchCubit.get(context).wayValue,
                                  activeColor:
                                      const Color.fromARGB(255, 105, 116, 235),
                                  onChanged: (val) {
                                    return SearchCubit.get(context)
                                        .changeValues(val);
                                  }),
                            ),
                            Expanded(
                              child: RadioListTile(
                                  title: const Text('Return'),
                                  value: false,
                                  groupValue: SearchCubit.get(context).wayValue,
                                  activeColor:
                                      const Color.fromARGB(255, 105, 116, 235),
                                  onChanged: (val) {
                                    return SearchCubit.get(context)
                                        .changeValues(val);
                                  }),
                            )
                          ],
                        ),
                        Gap(AppLayout.getHeigth(25)),
                        Row(
                          children: [
                            Expanded(
                              child: RadioListTile(
                                  title: const Text(
                                    'Economy',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  value: "economi",
                                  groupValue:
                                      SearchCubit.get(context).classValue[
                                          SearchCubit.get(context).classindex],
                                  activeColor:
                                      const Color.fromARGB(255, 105, 116, 235),
                                  onChanged: (val) {
                                    return SearchCubit.get(context).changeClas(
                                      val,
                                    );
                                  }),
                            ),
                            Expanded(
                              child: RadioListTile(
                                  title: const Text(
                                    'Business',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  value: 'business',
                                  groupValue:
                                      SearchCubit.get(context).classValue[
                                          SearchCubit.get(context).classindex],
                                  activeColor:
                                      const Color.fromARGB(255, 105, 116, 235),
                                  onChanged: (val) {
                                    return SearchCubit.get(context).changeClas(
                                      val,
                                    );
                                  }),
                            ),
                            Expanded(
                              child: RadioListTile(
                                  title: const Text(
                                    'First',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  value: 'first',
                                  groupValue:
                                      SearchCubit.get(context).classValue[
                                          SearchCubit.get(context).classindex],
                                  activeColor:
                                      const Color.fromARGB(255, 105, 116, 235),
                                  onChanged: (val) {
                                    return SearchCubit.get(context).changeClas(
                                      val,
                                    );
                                  }),
                            ),
                          ],
                        ),
                        Gap(AppLayout.getHeigth(25)),
                        defaultTextField(
                          width: double.infinity,
                          prefix: Icons.person_2,
                          controller: adultEditingController,
                          textInputType: TextInputType.number,
                          hintText: "Number of Adults",
                          validator: (val) {
                            if (val.isEmpty) {
                              return "this field cann't be empty";
                            }
                            int? value = int.tryParse(val);
                            if (value! > 10 || value < 1) {
                              return "please enter a desiered betwean 0 and 10";
                            }
                          },
                        ),
                        Gap(AppLayout.getHeigth(25)),
                        defaultTextField(
                          width: double.infinity,
                          prefix: Icons.child_care,
                          controller: childEditingController,
                          textInputType: TextInputType.number,
                          hintText: "Number of Children",
                          validator: (val) {
                            if (val.isNotEmpty) {
                              int? value = int.tryParse(val);
                              if (value! > 10) {
                                return "please enter a desiered value";
                              }
                            }
                          },
                        ),
                        Gap(AppLayout.getHeigth(25)),
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color:
                                    const Color.fromARGB(255, 105, 116, 235)),
                            child: TextButton(
                                onPressed: () {
                                  SearchCubit.get(context).selectDate(context);
                                },
                                child: Text(
                                  "Select date",
                                  style: Styles.headLinestyle4
                                      .copyWith(color: Colors.white),
                                )),
                          ),
                        ),
                        Gap(AppLayout.getHeigth(10)),
                        Center(
                          child: Text(
                              "${SearchCubit.get(context).selectedDate.toLocal()}"
                                  .split(' ')[0]),
                        ),
                        Gap(AppLayout.getHeigth(25)),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Checkbox(
                                value: SearchCubit.get(context).flexable,
                                onChanged: (newValue) {
                                  return SearchCubit.get(context)
                                      .changeFlexable(newValue);
                                },
                              ),
                              const Text(
                                'Flexable',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Gap(AppLayout.getHeigth(25)),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color.fromARGB(255, 105, 116, 235)),
                          child: TextButton(
                            child: Text(
                              "Find tickets",
                              style: Styles.headLinestyle4
                                  .copyWith(color: Colors.white),
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                if (deupartureEditingController
                                        .text.isNotEmpty &&
                                    arrivaltextEditingController
                                        .text.isNotEmpty) {
                                  int adultCount = int.tryParse(
                                          adultEditingController.text) ??
                                      0;
                                  int childCount = int.tryParse(
                                          childEditingController.text) ??
                                      0;

                                  int people = adultCount + childCount;
                                  SearchCubit.get(context).updatePeople(people);
                                  SearchCubit.get(context)
                                      .getallflight(
                                          deupartureEditingController.text,
                                          arrivaltextEditingController.text,
                                          SearchCubit.get(context)
                                              .selectedDate
                                              .toString(),
                                          SearchCubit.get(context).classValue[
                                              SearchCubit.get(context)
                                                  .classindex],
                                          people)
                                      .then((value) {
                                    SearchCubit.get(context).flights = value;
                                    print(SearchCubit.get(context)
                                        .flights[0]
                                        .classes
                                        .length);
                                  });
                                } else {
                                  showSnackbar(
                                      context: context,
                                      message: const Text(
                                          "the fields Shouldn't be Empty "),
                                      color: errorColor);
                                }
                              }
                            },
                          ),
                        ),
                        Gap(AppLayout.getHeigth(25)),
                      ],
                    ),
                  ),
                ),
                SearchCubit.get(context).flights.length != 0
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: SearchCubit.get(context)
                                .flights
                                .length, // Replace with your actual item count
                            itemBuilder: (BuildContext context, int index) {
                              return TripWidget(
                                  airportFrom: cubit.flights[index].airportFrom,
                                  airportTo: cubit.flights[index].airportTo,
                                  takeOffDate: cubit.flights[index].takeOffTime,
                                  arrivalDate: cubit.flights[index].takeOffDate,
                                  duration: cubit.flights[index].duration,
                                  price: cubit.flights[index].classes[0].price,
                                  flightNumber:
                                      cubit.flights[index].flightNumber,
                                  takeOffTime: cubit.flights[index].takeOffTime,
                                  people: cubit.people);
                            }),
                      )
                    : const Text("")
              ],
            ),
          ),
        );
      },
    );
  }
}

class AirPortInfo extends StatelessWidget {
  const AirPortInfo({
    super.key,
    required this.airportData,
  });
  final Airport airportData;

  @override
  Widget build(BuildContext context) {
    String airportCity = airportData.city;
    String airportName = airportData.name;
    String airportCountry = airportData.country;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                airportCountry,
                style: Styles.headLinestyle2,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                airportCity,
                style: Styles.headLinestyle3,
              ),
            ],
          ),
          const SizedBox(
            width: 50,
          ),
          Expanded(
            child: Text(
              airportName,
              style: Styles.headLinestyle3,
            ),
          ),
        ],
      ),
    );
  }
}

void _showOptionsModal(BuildContext context, bool isLoged) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isLoged)
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text("Profile"),
                onTap: () {
                  nextScreen(context, const UserProfile());
                },
              ),
            if (isLoged)
              ListTile(
                leading: const Icon(Icons.flight),
                title: const Text("My Trips"),
                onTap: () {
                  nextScreen(context, const MyTrips());
                },
              ),
            if (!isLoged)
              ListTile(
                leading: const Icon(Icons.login),
                title: const Text("Login"),
                onTap: () {
                  nextScreen(context, const LoginHome());
                },
              ),
            if (!isLoged)
              ListTile(
                leading: const Icon(Icons.person_add),
                title: const Text("Register"),
                onTap: () {
                  nextScreen(context, const Register());
                },
              ),
            ListTile(
              leading: const Icon(Icons.airplane_ticket),
              title: const Text("Find Tickt"),
              onTap: () {
                nextScreen(context, const FindTickt());
              },
            ),
            if (isLoged)
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text("Logout"),
                onTap: () {
                  CacheHelper.removeData(
                    key: 'mainUserToken',
                  );
                  nextScreen(context, const LoginHome());
                },
              ),
          ],
        ),
      );
    },
  );
}
