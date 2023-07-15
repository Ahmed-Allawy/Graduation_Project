// ignore_for_file: depend_on_referenced_packages, deprecated_member_use, unused_element

import 'dart:convert';
import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/model/ticketdata.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import '../../../shared/component/constants.dart';
import 'find_ticket_state.dart';

class FindTicketCubit extends Cubit<FindTicketState> {
  FindTicketCubit() : super(FindTicketStateInitial());

  static FindTicketCubit get(BuildContext context) => BlocProvider.of(context);

// //// locat data*********///
//   TicketData ticket = TicketData(
//       passengerName: 'John Doe',
//       flightNumber: 'ABC123',
//       departureTime: '10:00 AM',
//       arrivalTime: '12:00 PM',
//       duration: '2 hours',
//       seatNumber: '12A',
//       seatClass: 'Economy',
//       departure: 'New York',
//       arrival: 'Los Angeles',
//       id: 'f505faa0-0d6e-4694-8e2a-a0f758523c28');

// using api *********************///
  TicketData ticket = TicketData(
      flightId: 'flightId',
      flightNumber: 'flightNumber',
      takeOffTime: 'takeOffTime',
      takeOffDate: 'takeOffDate',
      landing: 'landing',
      status: 'status',
      duration: 'duration',
      noOfStops: 0,
      airlineName: 'airlineName',
      airportFrom: 'airportFrom',
      airportFromCountry: 'airportFromCountry',
      airportFromCity: 'airportFromCity',
      airportTo: 'airportTo',
      airportToCountry: 'airportToCountry',
      airportToCity: 'airportToCity',
      ticket: 'ticket',
      seat: 'seat',
      flightClass: 'flightClass',
      user: 'user',
      addedLuggage: 0,
      price: 0);

  Future<bool> fetchTickt(String id) async {
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('GET', Uri.parse('${uri}api/flight/ticket-details'));
    request.body = json.encode({"id": id});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var body = await response.stream.bytesToString();
      var data = jsonDecode(body);
      ticket = data.map((json) => TicketData.fromJson(json)).toList();
      emit(FindTicketStateFind());
      return true;
    } else {
      return false;
    }
  }

  ////// make ticket as pdf
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

  void makePDF(ScreenshotController screenshotController) {
    _screenShotTicket(screenshotController).then((value) {
      _downloadTicket(value);
    });
    emit(FindTicketStatePdf());
  }
}
