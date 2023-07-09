// ignore_for_file: camel_case_types, library_private_types_in_public_api, prefer_final_fields, unused_element, deprecated_member_use, non_constant_identifier_names, avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:graduation/view/presentations/Seat_screen/select_seat.dart';
import 'package:graduation/view/shared/component/constants.dart';

import 'package:graduation/view/shared/component/helperfunctions.dart';
import 'package:path_provider/path_provider.dart';

import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../../model/ticketdata.dart';
import '../../shared/component/components.dart';

import '../../shared/network/local/cach_helper.dart';
import 'cubit/ticket_cubit.dart';
import 'cubit/ticket_state.dart';

import 'package:pdf/widgets.dart' as pw;

class Ticket extends StatefulWidget {
  const Ticket({
    super.key,
  });

  @override
  _TicketState createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  Future<File> _screenShotTicket(
      ScreenshotController screenshotController) async {
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = await File('${directory.path}/image.png').create();
    await screenshotController
        .capture(delay: const Duration(milliseconds: 10))
        .then((image) async {
      if (image != null) {
        await imagePath.writeAsBytes(image);
      }
    });
    return imagePath;
  }

  Future<void> _downloadTicket(File imagePath) async {
    final pdf = pw.Document();
    final image = pw.MemoryImage(
      imagePath.readAsBytesSync(),
    );

    pdf.addPage(pw.Page(build: (pw.Context context) {
      return pw.Center(
        child: pw.Image(image),
      ); // Center
    })); // Pag

    // Save the PDF document to disk
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String path = '$dir/ticket.pdf';
    final File file = File(path);
    await file.writeAsBytes(await pdf.save());
    Share.shareFiles([file.path], text: 'ticket');
  }

  late final FlightTicketCubit _flightTicketCubit;

  @override
  void initState() {
    super.initState();
    _flightTicketCubit = FlightTicketCubit();
    // ...
  }

  @override
  Widget build(BuildContext context) {
    String str = CacheHelper.getData(key: 'seletedSeats');
    List<String> list = str
        .substring(1, str.length - 1) // Remove the brackets from the string
        .split(',') // Split the string into a list of values
        .map((e) => e.trim()) // Remove any whitespace around the values
        .toList(); // Convert the iterable to a list
    print(list); // Output: [ib, is]
    final List<TicketData> tickets = [
      TicketData(
          passengerName: 'John Doe',
          flightNumber: 'ABC123',
          departureTime: '10:00 AM',
          arrivalTime: '12:00 PM',
          duration: '2 hours',
          seatNumber: list[0],
          seatClass: 'Economy',
          departure: 'New York',
          arrival: 'Los Angeles',
          id: 'f505faa0-0d6e-4694-8e2a-a0f758523c28'),
      TicketData(
          passengerName: 'ahmed mousa abdullaha',
          flightNumber: 'ABC123',
          departureTime: '10:00 AM',
          arrivalTime: '12:00 PM',
          duration: '2 hours',
          seatNumber: '12A',
          seatClass: 'Economy',
          departure: 'New York',
          arrival: 'Los Angeles',
          id: 'f505faa0-0d6e-4694-8e2a-a0f758523c28'),
      TicketData(
        passengerName: 'ali mousa ahmed',
        flightNumber: 'ABC123',
        departureTime: '10:00 AM',
        arrivalTime: '12:00 PM',
        duration: '2 hours',
        seatNumber: '12A',
        seatClass: 'Economy',
        departure: 'New York',
        arrival: 'Los Angeles',
        id: 'f505faa0-0d6e-4694-8e2a-a0f758523c28',
      )
    ];

    FlightTicketCubit.get(context).addTickets(tickets);

    return Scaffold(
      backgroundColor: const Color(0xc61859ba),
      appBar: AppBar(
        backgroundColor: const Color(0xc61859ba),
        centerTitle: true,
        title: const Text("Ticket"),
        leading: BackButton(
          onPressed: () => nextScreenRep(context, const SelectSeat()),
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
                      arrivalTime: ticket.arrivalTime,
                      departureTime: ticket.departureTime,
                      duration: ticket.duration,
                      flightNumber: ticket.flightNumber,
                      passengerName: ticket.passengerName,
                      seatClass: ticket.seatClass,
                      seatNumber: ticket.seatNumber,
                      arrival: ticket.arrival,
                      departure: ticket.departure,
                      id: ticket.id,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _screenShotTicket(screenshotController).then((value) {
                        print('value is :$value');
                        _downloadTicket(value);
                      });
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
    _flightTicketCubit.close();
    super.dispose();
  }
}
