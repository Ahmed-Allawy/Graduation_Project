// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/view/presentations/Searching_Screen/SecondSearching_Screen.dart';
import 'package:graduation/view/shared/component/helperfunctions.dart';

import '../../shared/component/components.dart';
import '../../../model/persondata.dart';
import 'cubit/search_cubit.dart';

class PicScreen extends StatelessWidget {
  List<Person> person;
  PicScreen({
    Key? key,
    required this.person,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 105, 116, 235),
            centerTitle: true,
            title: const Text("Adding Face pic"),
            leading: BackButton(
              onPressed: () {
                nextScreenRep(context, const SecondSearchingScreen());
              },
            ),
          ),
          body: ListView.builder(
            itemCount: person.length,
            itemBuilder: (context, index) {
              Person currentPerson = person[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      defaultTextButton(
                        text: "Take Photo",
                        onpressed: () {},
                      ),
                      const SizedBox(width: 8),
                      Text(currentPerson.firstName),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
