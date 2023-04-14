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
                selectedCountry: deupartureEditingController.text,
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
                selectedCountry: arrivaltextEditingController.text,
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
              Row(
                children: [
                  Expanded(
                    child: RadioListTile(
                        title: const Text('one way'),
                        value: true,
                        groupValue: SearchCubit.get(context).value,
                        activeColor: const Color.fromARGB(255, 105, 116, 235),
                        onChanged: (val) {
                          return SearchCubit.get(context).changeValues(val);
                        }),
                  ),
                  Expanded(
                    child: RadioListTile(
                        title: const Text('two way'),
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
              Gap(AppLayout.getHeigth(25)),
              SizedBox(
                child: Column(
                  children: [
                    /*this container for blue part*/
                    Container(
                      padding: EdgeInsets.all(AppLayout.getHeigth(16)),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(Icons.person),
                              const Gap(25),
                              Text(
                                "the Compeny name",
                                style: Styles.headLinestyle4,
                              )
                            ],
                          ),
                          const Gap(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "11:00",
                                      style: Styles.headLinestyle3
                                          .copyWith(color: Styles.textColor),
                                    ),
                                    const Gap(5),
                                    Text(
                                      "LHD",
                                      style: Styles.headLinestyle4
                                          .copyWith(color: Styles.textColor),
                                    ),
                                  ],
                                ),
                              ),
                              const ThickContainer(
                                iscolor: true,
                              ),
                              Expanded(
                                child: Stack(
                                  children: [
                                    const SizedBox(
                                        height: 24,
                                        child: DotedWidget(
                                          color: Color.fromARGB(
                                              255, 105, 116, 235),
                                          section: 6,
                                          width: 4,
                                        )),
                                    Center(
                                      child: Transform.rotate(
                                          angle: 1.5,
                                          child: const Icon(
                                            Icons.airplanemode_on_outlined,
                                            color: Colors.blue,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                              const ThickContainer(
                                iscolor: true,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "13:00",
                                      style: Styles.headLinestyle3
                                          .copyWith(color: Styles.textColor),
                                    ),
                                    const Gap(5),
                                    Text(
                                      "CIR",
                                      style: Styles.headLinestyle4
                                          .copyWith(color: Styles.textColor),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "0h 15m",
                                  style: Styles.headLinestyle4
                                      .copyWith(color: Styles.textColor),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(5),
                    Container(
                      padding: EdgeInsets.all(AppLayout.getHeigth(16)),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Text(
                            "510 \$",
                            style: Styles.headLinestyle3
                                .copyWith(color: Styles.textColor),
                          ),
                          const Gap(25),
                          Text("the price", style: Styles.headLinestyle4),
                          const Spacer(),
                          Text(
                            "Book Now",
                            style: Styles.headLinestyle3.copyWith(
                              color: const Color.fromARGB(255, 105, 116, 235),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
