class TicketData {
  final String flightId;
  final String flightNumber;
  final String takeOffTime;
  final String takeOffDate;
  final String landing;
  final String status;
  final String duration;
  final int noOfStops;
  final String airlineName;
  final String airportFrom;
  final String airportFromCountry;
  final String airportFromCity;
  final String airportTo;
  final String airportToCountry;
  final String airportToCity;
  final String ticket;
  final String seat;
  final String flightClass;
  final dynamic price;
  final int addedLuggage;
  final String user;

  TicketData({
    required this.flightId,
    required this.flightNumber,
    required this.takeOffTime,
    required this.takeOffDate,
    required this.landing,
    required this.status,
    required this.duration,
    required this.noOfStops,
    required this.airlineName,
    required this.airportFrom,
    required this.airportFromCountry,
    required this.airportFromCity,
    required this.airportTo,
    required this.airportToCountry,
    required this.airportToCity,
    required this.ticket,
    required this.seat,
    required this.flightClass,
    required this.price,
    required this.addedLuggage,
    required this.user,
  });
  factory TicketData.fromJson(Map<String, dynamic> json) {
    return TicketData(
      flightId: json['flight_id'],
      flightNumber: json['flight_number'],
      takeOffTime: json['take_off_time'],
      takeOffDate: json['take_off_date'],
      landing: json['landing'],
      status: json['status'],
      duration: json['duration'],
      noOfStops: json['no_of_stops'] ?? 0,
      airlineName: json['airline_name'],
      airportFrom: json['airportFrom'],
      airportFromCountry: json['airportFromCountry'],
      airportFromCity: json['airportFromCity'],
      airportTo: json['airportTo'],
      airportToCountry: json['airportToCountry'],
      airportToCity: json['airportToCity'],
      ticket: json['ticket'],
      seat: json['seat'],
      flightClass: json['class'],
      price: json['price'] ?? 0,
      addedLuggage: json['added_lagguge'] ?? 0,
      user: json['user'],
    );
  }
}
