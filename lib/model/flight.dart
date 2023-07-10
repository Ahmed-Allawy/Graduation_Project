class Flight {
  String flightNumber;
  String takeOffTime;
  String takeOffDate;
  String status;
  String duration;
  int numberOfStops;
  String airlineName;
  String airportFrom;
  String airportTo;
  List<FlightClass> classes;

  Flight({
    required this.flightNumber,
    required this.takeOffTime,
    required this.takeOffDate,
    required this.status,
    required this.duration,
    required this.numberOfStops,
    required this.airlineName,
    required this.airportFrom,
    required this.airportTo,
    required this.classes,
  });

  factory Flight.fromJson(Map<String, dynamic> json) {
    return Flight(
      flightNumber: json['flight_number'],
      takeOffTime: json['take_off_time'],
      takeOffDate: json['take_off_date'],
      status: json['status'],
      duration: json['duration'],
      numberOfStops: json['no_of_stops'],
      airlineName: json['airline_name'],
      airportFrom: json['airportFrom'],
      airportTo: json['airportTo'],
      classes: (json['classes'] as List)
          .map((classJson) => FlightClass.fromJson(classJson))
          .toList(),
    );
  }
}

class FlightClass {
  String classType;
  double price;
  int seats;

  FlightClass({
    required this.classType,
    required this.price,
    required this.seats,
  });

  factory FlightClass.fromJson(Map<String, dynamic> json) {
    return FlightClass(
      classType: json['class_type'],
      price: json['price'].toDouble(),
      seats: json['seats'],
    );
  }
}
