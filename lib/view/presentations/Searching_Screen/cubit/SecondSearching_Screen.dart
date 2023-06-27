// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:graduation/view/presentations/Searching_Screen/cubit/search_cubit.dart';

import '../../../shared/component/components.dart';

class SecondSearchingScreen extends StatelessWidget {
  const SecondSearchingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SearchCubit.get(context).addMorePerson();

    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 105, 116, 235),
            centerTitle: true,
            title: const Text("Adding the passenger"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(25),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: SearchCubit.get(context).personFields,
                  ),
                  defaultButton(
                    text: "Add more person",
                    onPressed: () => SearchCubit.get(context).addMorePerson(),
                  ),
                  const Gap(25),
                  if (SearchCubit.get(context).showUndoButton)
                    defaultButton(
                        onPressed: () =>
                            SearchCubit.get(context).removePerson(),
                        text: "remove person"),
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
