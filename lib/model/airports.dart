import 'dart:convert';

class Airport {
  String name;
  String city;
  String country;

  Airport({
    required this.name,
    required this.city,
    required this.country,
  });

  factory Airport.fromJson(Map<String, dynamic> json) {
    return Airport(
      name: json['AP_name'],
      city: json['AP_city'],
      country: json['AP_country'],
    );
  }

  get query => null;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'AP_name': name,
      'AP_city': city,
      'AP_country': country,
    };
  }

  String toJson() => json.encode(toMap());
}
