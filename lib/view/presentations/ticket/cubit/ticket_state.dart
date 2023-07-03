abstract class FlightTicketState {}

class FlightTicketStateInitial extends FlightTicketState {}

class FlightTicketStateRemove extends FlightTicketState {}

class FlightTicketStateAdd extends FlightTicketState {}

class TicketData {
  final String passengerName;
  final String flightNumber;
  final String departureTime;
  final String arrivalTime;
  final String duration;
  final String seatNumber;
  final String seatClass;
  final String departure;
  final String arrival;

  TicketData({
    required this.passengerName,
    required this.flightNumber,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.seatNumber,
    required this.seatClass,
    required this.departure,
    required this.arrival,
  });
}
