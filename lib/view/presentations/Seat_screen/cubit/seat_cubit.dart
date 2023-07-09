// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/view/presentations/Seat_screen/cubit/seat_state.dart';
import 'package:http/http.dart' as http;

import '../../../shared/component/constants.dart';

class SeatCubit extends Cubit<SeatState> {
  SeatCubit() : super(SeatStateInitial());
  static SeatCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> postSeatsUsers(String seatsId, List<String> users) async {
    List<String> seats = convertToListString(seatsId);
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('POST', Uri.parse('${uri}api/flight/reserve-seats'));
    request.body = json.encode({
      'seats': seats,
      'users': users,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('Seats and users added successfully.');
    } else {
      print('Error adding seats and users: ${response.statusCode}');
    }
  }

  List<String> convertToListString(String str) {
    List<String> list = str
        .substring(1, str.length - 1) // Remove the brackets from the string
        .split(',') // Split the string into a list of values
        .map((e) => e.trim()) // Remove any whitespace around the values
        .toList(); // Convert the iterable to a list
    print(list);
    return list;
  }
}
