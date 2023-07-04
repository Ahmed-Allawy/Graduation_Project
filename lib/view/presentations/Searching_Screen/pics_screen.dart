// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:graduation/view/presentations/Searching_Screen/cubit/search_cubit.dart';

import '../../shared/component/components.dart';
import '../../shared/component/models.dart';

// ignore: must_be_immutable
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
          ),
          body: Center(
            child: defaultTextButton(
                text: "Take Photo",
                onpressed: () {
                  print(this.person);
                }),
          ),
        );
      },
    );
  }
}
