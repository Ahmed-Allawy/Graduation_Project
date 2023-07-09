// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:graduation/view/presentations/Searching_Screen/Searching_Screen.dart';
import 'package:graduation/view/presentations/find_ticket/cubit/find_ticket_cubit.dart';
import 'package:graduation/view/presentations/find_ticket/cubit/find_ticket_state.dart';

import 'package:graduation/view/shared/component/constants.dart';
import 'package:screenshot/screenshot.dart';

import '../../shared/component/components.dart';
import '../../shared/component/helperfunctions.dart';

import '../../shared/network/local/cach_helper.dart';

class FindTickt extends StatefulWidget {
  const FindTickt({Key? key}) : super(key: key);

  @override
  _FindTicktState createState() => _FindTicktState();
}

bool isloading = false;

class _FindTicktState extends State<FindTickt> {
  @override
  Widget build(BuildContext context) {
    ScreenshotController screenshotController = ScreenshotController();
    var formKey = GlobalKey<FormState>();
    final TextEditingController ticktNumberController = TextEditingController();
    return Scaffold(
      backgroundColor: const Color(0xc61859ba),
      appBar: AppBar(
        backgroundColor: const Color(0xc61859ba),
        centerTitle: true,
        title: const Text("Search for a Ticket"),
        leading: BackButton(
          onPressed: () => nextScreenRep(
              context,
              SearchingScreen(
                isloged: CacheHelper.getData(key: 'isLoged'),
              )),
        ),
      ),
      body: BlocConsumer<FindTicketCubit, FindTicketState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(children: <Widget>[
                Form(
                  key: formKey,
                  child: Flex(
                    mainAxisAlignment: MainAxisAlignment.center,
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Flexible(
                        flex: 5,
                        child: Container(
                          padding: const EdgeInsets.only(left: 30),
                          decoration: const BoxDecoration(
                              color: fontColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40))),
                          child: TextFormField(
                            controller: ticktNumberController,
                            decoration: InputDecoration(
                                hintText: 'Enter ticket number',
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: primarycolor,
                                ),
                                fillColor: Styles.bgColor),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a ticket number';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              // Perform search operation here
                              FindTicketCubit.get(context)
                                  .fetchTickt(ticktNumberController.text)
                                  .then((value) {
                                setState(() {
                                  isloading = !value;
                                });
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(16),
                          ),
                          child: const Icon(
                            Icons.search,
                            color:
                                Colors.white, // Customize the icon color here
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                isloading
                    ? const Center(
                        heightFactor: 20,
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: [
                          Screenshot(
                            controller: screenshotController,
                            child: TicketShape(
                              arrivalTime: FindTicketCubit.get(context)
                                  .ticket
                                  .arrivalTime,
                              departureTime: FindTicketCubit.get(context)
                                  .ticket
                                  .departureTime,
                              duration:
                                  FindTicketCubit.get(context).ticket.duration,
                              flightNumber: FindTicketCubit.get(context)
                                  .ticket
                                  .flightNumber,
                              passengerName: FindTicketCubit.get(context)
                                  .ticket
                                  .passengerName,
                              seatClass:
                                  FindTicketCubit.get(context).ticket.seatClass,
                              seatNumber: FindTicketCubit.get(context)
                                  .ticket
                                  .seatNumber,
                              arrival:
                                  FindTicketCubit.get(context).ticket.arrival,
                              departure:
                                  FindTicketCubit.get(context).ticket.departure,
                              id: FindTicketCubit.get(context).ticket.id,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              FindTicketCubit.get(context)
                                  .makePDF(screenshotController);
                            },
                            child: const Text('Download it'),
                          ),
                        ],
                      ),
              ]),
            ),
          );
        },
      ),
    );
  }
}
