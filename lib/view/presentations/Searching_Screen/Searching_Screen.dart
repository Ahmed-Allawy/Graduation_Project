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
import 'package:graduation/view/shared/component/constants.dart';
import 'package:graduation/view/shared/component/helperfunctions.dart';

import '../../../model/airports.dart';
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
        return Scaffold(
          backgroundColor: Styles.bgColor,
          body: ListView(
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
                      SearchCubit.get(context)
                          .sumbitCountery(item, deupartureEditingController);
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
                      SearchCubit.get(context)
                          .sumbitCountery(item, arrivaltextEditingController);
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
                        groupValue: SearchCubit.get(context).value,
                        activeColor: const Color.fromARGB(255, 105, 116, 235),
                        onChanged: (val) {
                          return SearchCubit.get(context).changeValues(val);
                        }),
                  ),
                  Expanded(
                    child: RadioListTile(
                        title: const Text('Return'),
                        value: false,
                        groupValue: SearchCubit.get(context).value,
                        activeColor: const Color.fromARGB(255, 105, 116, 235),
                        onChanged: (val) {
                          return SearchCubit.get(context).changeValues(val);
                        }),
                  )
                ],
              ),
              Gap(AppLayout.getHeigth(25)),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color.fromARGB(255, 105, 116, 235)),
                  child: TextButton(
                      onPressed: () {
                        SearchCubit.get(context).selectDate(context);
                      },
                      child: Text(
                        "Select date",
                        style:
                            Styles.headLinestyle4.copyWith(color: Colors.white),
                      )),
                ),
              ),
              Gap(AppLayout.getHeigth(10)),
              Center(
                child: Text("${SearchCubit.get(context).selectedDate.toLocal()}"
                    .split(' ')[0]),
              ),
              Gap(AppLayout.getHeigth(25)),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromARGB(255, 105, 116, 235)),
                child: TextButton(
                  child: Text(
                    "Find tickets",
                    style: Styles.headLinestyle4.copyWith(color: Colors.white),
                  ),
                  onPressed: () {
                    if (deupartureEditingController.text.isNotEmpty &&
                        arrivaltextEditingController.text.isNotEmpty) {
                      if (SearchCubit.get(context)
                              .countries
                              .contains(deupartureEditingController.text) &&
                          SearchCubit.get(context)
                              .countries
                              .contains(arrivaltextEditingController.text)) {
                      } else {
                        showSnackbar(
                            context: context,
                            message:
                                const Text("you should select the countiers"),
                            color: errorColor);
                      }
                    } else {
                      showSnackbar(
                          context: context,
                          message: const Text("the fields Shouldn't be Empty "),
                          color: errorColor);
                    }
                  },
                ),
              ),
              Gap(AppLayout.getHeigth(25)),
              const TripWidget(
                arrivalCity: '',
                arrivalDate: '',
                departureCity: '',
                departureDate: '',
                planeID: '',
                price: '',
                tripTime: '',
              ),
              const TripWidget(
                arrivalCity: '',
                arrivalDate: '',
                departureCity: '',
                departureDate: '',
                planeID: '',
                price: '',
                tripTime: '',
              ),
              const TripWidget(
                arrivalCity: '',
                arrivalDate: '',
                departureCity: '',
                departureDate: '',
                planeID: '',
                price: '',
                tripTime: '',
              ),
            ],
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
          Text(
            airportName,
            style: Styles.headLinestyle3,
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
      return Column(
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
        ],
      );
    },
  );
}
