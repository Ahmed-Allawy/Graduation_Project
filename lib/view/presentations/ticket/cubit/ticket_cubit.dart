// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ticket_state.dart';

class FlightTicketCubit extends Cubit<FlightTicketState> {
  FlightTicketCubit() : super(FlightTicketStateInitial());

  static FlightTicketCubit get(BuildContext context) =>
      BlocProvider.of(context);

  List<TicketData> tickets = [];

  void addTickets(tickets) {
    this.tickets = tickets;
    emit(FlightTicketStateAdd());
  }

  void removeTicket(int index) {
    tickets.removeAt(index);
    // List<TicketData>.from(state.tickets)..removeAt(index);
    emit(FlightTicketStateRemove());
  }
}
