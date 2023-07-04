import 'dart:convert';

class Airport {
  String fullName;
  String id;
  String name;
  String city;
  String? state;
  String country;
  String phone;

  Airport({
    required this.fullName,
    required this.id,
    required this.name,
    required this.city,
    required this.state,
    required this.country,
    required this.phone,
  });
  factory Airport.fromJson(Map<String, dynamic> json) {
    return Airport(
      fullName: json['AP_fullName'],
      id: json['AP_id'],
      name: json['AP_name'],
      city: json['AP_city'],
      state: json['AP_state'],
      country: json['AP_country'],
      phone: json['AP_phone'],
    );
  }

  get query => null;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'AP_fullName': fullName,
      'AP_id': id,
      'AP_name': name,
      'AP_city': city,
      'AP_state': state,
      'AP_country': country,
      'AP_phone': phone,
    };
  }

  String toJson() => json.encode(toMap());
}
