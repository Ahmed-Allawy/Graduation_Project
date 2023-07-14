// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../shared/component/components.dart';
import '../../shared/component/constants.dart';
import '../../shared/component/helperfunctions.dart';
import '../../shared/component/layout.dart';
import '../Seat_screen/select_seat.dart';
import 'cubit/search_cubit.dart';

// ignore: must_be_immutable
class PicScreen extends StatelessWidget {
  List<String> token;
  // List<TextEditingController> firstnames;
  List<TextEditingController> firstnames;
  PicScreen({
    Key? key,
    required this.token,
    required this.firstnames,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<bool> status = List<bool>.filled(token.length, false);
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
                    itemCount: firstnames.length,
                    itemBuilder: ((context, index) => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  firstnames[index].text,
                                  // firstnames[index].text,
                                  style: const TextStyle(fontSize: 20),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                defaultTextButton(
                                    text: "Take photo",
                                    onpressed: () {
                                      SearchCubit.get(context)
                                          .pickImageCamera(token[index])
                                          .then((value) {
                                        status[index] = !value;
                                        if (value) {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: const Text('Photo Failed'),
                                              content: const Text(
                                                  '\t\tPlease enter another photo\n\t\tshowing the full face\n\t\tand with natural light'),
                                              actions: [
                                                TextButton(
                                                  child: const Text('OK'),
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                      });
                                    }),
                                const Gap(10),
                                status[index]
                                    ? const Icon(
                                        Icons.car_crash,
                                        color: Colors.green,
                                      )
                                    : const Icon(
                                        Icons.car_crash,
                                        color: Colors.red,
                                      )
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            )
                          ],
                        ))),
                const Spacer(),
                defaultButton(
                    text: "Sumbit",
                    onPressed: () {
                      bool s = true;
                      for (int i = 0; i < status.length; i++) {
                        if (status[i] == false) {
                          s = false;
                        }
                      }

                      ////got to nextscreen if all photos is valid
                      if (s) {
                        nextScreen(
                            context,
                            SelectSeat(
                              classID: SearchCubit.get(context).classid,
                              usersID: SearchCubit.get(context).userId,
                              price: SearchCubit.get(context).price,
                            ));
                      }
                      ////show Dialog if all photos is valid
                      if (!s) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Photo Failed'),
                            content: const Text(
                                'please make sure that all photos are valid'),
                            actions: [
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                        );
                      }
                    }),
                const Gap(15),
                Text.rich(TextSpan(
                    text: "or you can Skip to the seat ",
                    style: TextStyle(
                        fontSize: AppLayout.getWidth(fontsize2),
                        color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                          text: "Page",
                          style: const TextStyle(
                              color: textColor,
                              decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              nextScreen(
                                  context,
                                  SelectSeat(
                                    classID: SearchCubit.get(context).classid,
                                    usersID: SearchCubit.get(context).userId,
                                    price: SearchCubit.get(context).price,
                                  ));
                            })
                    ])),
                const Gap(15),
              ],
            ));
      },
    );
  }
}
