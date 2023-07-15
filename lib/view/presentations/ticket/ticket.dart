// ignore_for_file: camel_case_types, library_private_types_in_public_api, prefer_final_fields, unused_element, deprecated_member_use, non_constant_identifier_names, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/view/presentations/Searching_Screen/Searching_Screen.dart';

import 'package:graduation/view/shared/component/constants.dart';

import 'package:graduation/view/shared/component/helperfunctions.dart';

import 'package:screenshot/screenshot.dart';

import '../../shared/component/components.dart';

import '../../shared/network/local/cach_helper.dart';
import 'cubit/ticket_cubit.dart';
import 'cubit/ticket_state.dart';

class Ticket extends StatefulWidget {
  final String superSuerID;
  const Ticket({
    super.key,
    required this.superSuerID,
  });

  @override
  _TicketState createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  @override
  void initState() {
    super.initState();
////////////// data from api ***********************//////////
    FlightTicketCubit.get(context)
        .fetchTicketData(widget.superSuerID)
        .then((value) {
      print(value);
      FlightTicketCubit.get(context).tickets = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(FlightTicketCubit.get(context).tickets);
    ///////////////////////locat data******************************///////

    // final List<TicketData> tickets = [
    //   TicketData(
    //       passengerName: 'John Doe',
    //       flightNumber: 'ABC123',
    //       departureTime: '10:00 AM',
    //       arrivalTime: '12:00 PM',
    //       duration: '2 hours',
    //       seatNumber: list[0],
    //       seatClass: 'Economy',
    //       departure: 'New York',
    //       arrival: 'Los Angeles',
    //       id: 'f505faa0-0d6e-4694-8e2a-a0f758523c28'),
    //   TicketData(
    //       passengerName: 'ahmed mousa abdullaha',
    //       flightNumber: 'ABC123',
    //       departureTime: '10:00 AM',
    //       arrivalTime: '12:00 PM',
    //       duration: '2 hours',
    //       seatNumber: '12A',
    //       seatClass: 'Economy',
    //       departure: 'New York',
    //       arrival: 'Los Angeles',
    //       id: 'f505faa0-0d6e-4694-8e2a-a0f758523c28'),
    //   TicketData(
    //     passengerName: 'ali mousa ahmed',
    //     flightNumber: 'ABC123',
    //     departureTime: '10:00 AM',
    //     arrivalTime: '12:00 PM',
    //     duration: '2 hours',
    //     seatNumber: '12A',
    //     seatClass: 'Economy',
    //     departure: 'New York',
    //     arrival: 'Los Angeles',
    //     id: 'f505faa0-0d6e-4694-8e2a-a0f758523c28',
    //   )
    // ];

    // FlightTicketCubit.get(context).addTickets(tickets);

    return Scaffold(
      backgroundColor: const Color(0xc61859ba),
      appBar: AppBar(
        backgroundColor: const Color(0xc61859ba),
        centerTitle: true,
        title: const Text("Ticket"),
        leading: BackButton(
          onPressed: () => nextScreenRep(
              context,
              SearchingScreen(
                isloged: CacheHelper.getData(key: 'isLoged'),
              )),
        ),
      ),
      body: BlocBuilder<FlightTicketCubit, FlightTicketState>(
        builder: (context, state) {
          if (FlightTicketCubit.get(context).tickets.isEmpty) {
            return Center(
                child: Text(
              'There are not any\ntickets booked yet.',
              style: Styles.headLinestyle1,
            ));
          }
          return ListView.builder(
            itemCount: FlightTicketCubit.get(context).tickets.length,
            itemBuilder: (BuildContext context, int index) {
              final ticket = FlightTicketCubit.get(context).tickets[index];
              ScreenshotController screenshotController =
                  ScreenshotController();
              return Column(
                children: <Widget>[
                  Screenshot(
                    controller: screenshotController,
                    child: TicketShape(
                      arrivalTime: ticket.landing,
                      departureTime: ticket.takeOffDate,
                      duration: ticket.duration,
                      flightNumber: ticket.flightNumber,
                      passengerName: ticket.user,
                      seatClass: ticket.flightClass,
                      seatNumber: ticket.seat,
                      arrival: ticket.airportFrom,
                      departure: ticket.airportTo,
                      id: ticket.ticket,
                      price: ticket.price,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      FlightTicketCubit.get(context)
                          .makePDF(screenshotController);
                    },
                    child: const Text('Download it'),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
