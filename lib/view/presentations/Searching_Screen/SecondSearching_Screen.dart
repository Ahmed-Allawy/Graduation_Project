// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:graduation/view/presentations/Searching_Screen/Searching_Screen.dart';
import 'package:graduation/view/presentations/Searching_Screen/cubit/search_cubit.dart';
import 'package:graduation/view/shared/component/helperfunctions.dart';

import '../../shared/component/components.dart';
import '../../shared/network/local/cach_helper.dart';

class SecondSearchingScreen extends StatelessWidget {
  const SecondSearchingScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (SearchCubit.get(context).personFields.isEmpty) {
      SearchCubit.get(context).addMorePerson();
    }
    SearchCubit.get(context).clearPersons();

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
                  Column(
                    children: SearchCubit.get(context).personFields,
                  ),
                  Flex(
                    mainAxisAlignment: MainAxisAlignment.center,
                    direction: Axis.horizontal,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () =>
                            SearchCubit.get(context).addMorePerson(),
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(16),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white, // Customize the icon color here
                        ),
                      ),
                      const Gap(25),
                      if (SearchCubit.get(context).showUndoButton)
                        ElevatedButton(
                          onPressed: () =>
                              SearchCubit.get(context).removePerson(),
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(16),
                          ),
                          child: const Icon(
                            Icons.delete,
                            color:
                                Colors.white, // Customize the icon color here
                          ),
                        ),
                    ],
                  ),
                  const Gap(25),
                  defaultButton(
                    text: "Submit",
                    onPressed: () => SearchCubit.get(context).p(context),
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
