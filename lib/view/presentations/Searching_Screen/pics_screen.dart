import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:graduation/view/presentations/Seat_screen/select_seat.dart';
import 'package:graduation/view/shared/component/helperfunctions.dart';

import '../../shared/component/components.dart';
import '../../../model/persondata.dart';
import 'cubit/search_cubit.dart';

// ignore: must_be_immutable
class PicScreen extends StatelessWidget {
  List<Person> person;
  List<String> token;
  PicScreen({
    Key? key,
    required this.person,
    required this.token,
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
            body: Column(
              children: [
                const Spacer(),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: person.length,
                    itemBuilder: ((context, index) => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  person[index].firstName,
                                  style: const TextStyle(fontSize: 15),
                                ),
                                const Gap(20),
                                defaultTextButton(
                                    text: "Take photo",
                                    onpressed: () {
                                      SearchCubit.get(context)
                                          .pickImageCamera();
                                    })
                              ],
                            ),
                          ],
                        ))),
                const Spacer(),
                defaultButton(
                    text: "Submit",
                    onPressed: () {
                      nextScreen(context, const SelectSeat());
                    }),
                const Gap(10)
              ],
            ));
      },
    );
  }
}
