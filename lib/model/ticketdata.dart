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
  final String id;

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
    required this.id,
  });
  factory TicketData.fromJson(Map<String, dynamic> json) {
    return TicketData(
      passengerName: json['passenger_name'],
      flightNumber: json['flight_number'],
      departureTime: json['departure_time'],
      arrivalTime: json['arrival_time'],
      duration: json['duration'],
      seatNumber: json['seat_number'],
      seatClass: json['seat_class'],
      departure: json['departure'],
      arrival: json['arrival'],
      id: json['id'],
    );
  }
}
