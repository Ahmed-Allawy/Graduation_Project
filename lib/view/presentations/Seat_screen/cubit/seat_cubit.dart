// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/model/seatsdata.dart';
import 'package:graduation/view/presentations/Seat_screen/cubit/seat_state.dart';
import 'package:http/http.dart' as http;

import '../../../shared/component/constants.dart';

class SeatCubit extends Cubit<SeatState> {
  SeatCubit() : super(SeatStateInitial());
  static SeatCubit get(BuildContext context) => BlocProvider.of(context);

//// get seats by class id from databse
  List<SeatData> seats = [];
//// return selected seats id
  List<String> selectedSeatsID = [];
  Future<List<SeatData>> fetchSeatsData(String id) async {
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('POST', Uri.parse('${uri}api/flight/class-seats'));
    request.body = json.encode({
      "id": id,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String body = await response.stream.bytesToString();
      print('body from seats is :$body');
      List<dynamic> jsonList = jsonDecode(body);
      List<SeatData> c =
          jsonList.map((json) => SeatData.fromJson(json)).toList();
      emit(SeatStateFetch());
      return c;
    } else {
      print('body from seats is empty');
      emit(SeatStateFetch());
      return [];
    }
  }

//////send seats and users ids to databse
  Future<bool> postSeatsUsers(List<String> seatsId, List<String> users) async {
    // List<String> seats = convertToListString(seatsId);
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('POST', Uri.parse('${uri}api/flight/reserve-seats'));

    var obj = {
      "seats": seatsId,
      "users": [
        {"clients": users, "childs": []}
      ]
    };
    print(json.encode(obj));
    request.body = json.encode(obj);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('Seats and users added successfully.');
      emit(SeatStatePost());
      return true;
    } else {
      print('Error adding seats and users: ${response.statusCode}');
      emit(SeatStatePost());
      return false;
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
