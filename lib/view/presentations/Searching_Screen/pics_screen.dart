import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/component/components.dart';
import '../../shared/component/models.dart';
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
                      SizedBox(width: 8),
                      Text(currentPerson.firstName),
                    ],
                  ),
                  SizedBox(height: 16),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
