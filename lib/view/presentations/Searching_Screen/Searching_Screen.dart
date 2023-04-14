// ignore_for_file: file_names

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:graduation/view/presentations/Searching_Screen/cubit/search_cubit.dart';
import 'package:graduation/view/shared/component/constants.dart';

import '../../shared/component/components.dart';
import '../../shared/component/layout.dart';

class SearchingScreen extends StatefulWidget {
  const SearchingScreen({super.key});

  @override
  State<SearchingScreen> createState() => _SearchingScreenState();
}

class _SearchingScreenState extends State<SearchingScreen> {
  final GlobalKey<AutoCompleteTextFieldState<String>> arrivalCompleteKey =
      GlobalKey();
  final TextEditingController arrivaltextEditingController =
      TextEditingController();
  final GlobalKey<AutoCompleteTextFieldState<String>> deupartureCompleteKey =
      GlobalKey();
  final TextEditingController deupartureEditingController =
      TextEditingController();
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
              Text(
                "What are \nyou looking for?",
                style: Styles.headLinestyle1,
              ),
              Gap(AppLayout.getHeigth(25)),
              Gap(AppLayout.getHeigth(25)),
              customTextFieldSerach(
                hint: "Departure",
                autoCompleteKey: deupartureCompleteKey,
                textEditingController: deupartureEditingController,
                selectedCountry: SearchCubit.get(context).selectedCountry,
                countries: SearchCubit.get(context).countries,
                sumbit: (item) {},
                build: (context, item) {
                  return ListTile(
                    title: Text(item),
                    onTap: () {
                      SearchCubit.get(context)
                          .sumbitCountery(item, deupartureEditingController);
                    },
                  );
                },
              ),
              Gap(AppLayout.getHeigth(15)),
              customTextFieldSerach(
                hint: "Arrival",
                autoCompleteKey: arrivalCompleteKey,
                textEditingController: arrivaltextEditingController,
                selectedCountry: SearchCubit.get(context).selectedCountry,
                countries: SearchCubit.get(context).countries,
                sumbit: (item) {},
                build: (context, item) {
                  return ListTile(
                    title: Text(item),
                    onTap: () {
                      SearchCubit.get(context)
                          .sumbitCountery(item, arrivaltextEditingController);
                    },
                  );
                },
              ),
              Gap(AppLayout.getHeigth(25)),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blueAccent),
                child: TextButton(
                  child: Text(
                    "Find tickets",
                    style: Styles.headLinestyle4.copyWith(color: Colors.white),
                  ),
                  onPressed: () {
                    if (deupartureEditingController.text.isNotEmpty &&
                        arrivaltextEditingController.text.isNotEmpty) {
                      // this mean there is something
                      if (SearchCubit.get(context)
                              .countries
                              .contains(deupartureEditingController.text) &&
                          SearchCubit.get(context)
                              .countries
                              .contains(arrivaltextEditingController.text)) {
                        //this mean that the inputs valdated
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
              Gap(AppLayout.getHeigth(35)),
              Gap(AppLayout.getHeigth(20)),
              const Gap(5),
            ],
          ),
        );
      },
    );
  }
}
