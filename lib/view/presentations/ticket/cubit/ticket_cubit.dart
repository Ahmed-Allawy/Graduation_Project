// ignore_for_file: depend_on_referenced_packages, deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../model/ticketdata.dart';
import '../../../shared/component/constants.dart';
import 'ticket_state.dart';
import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class FlightTicketCubit extends Cubit<FlightTicketState> {
  FlightTicketCubit() : super(FlightTicketStateInitial());

  static FlightTicketCubit get(BuildContext context) =>
      BlocProvider.of(context);

  List<TicketData> tickets = [];

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
    emit(FlightTicketStatePDF());
  }

  ///get ticket data form api

  Future<List<TicketData>> fetchTicketData(String id) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('${uri}api/flight/tickets-with-linked-users'));
    request.body = json.encode({
      "id": id,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String body = await response.stream.bytesToString();

      List<dynamic> jsonList = jsonDecode(body);

      List<TicketData> c =
          jsonList.map((json) => TicketData.fromJson(json)).toList();
      print('data c is :$c');
      emit(FlightTicketStateAPI());
      return c;
    } else {
      print('data not c is ');
      emit(FlightTicketStateAPI());
      return [];
    }
  }
}
