// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Person {
  String firstName;
  String lastName;
  String passport;
  String country;
  String email;
  String password;
  String phoneNumber;
  String age;
  String gender;

  /// add passowrd field to this model and modify it in the form
  Person({
    required this.firstName,
    required this.lastName,
    required this.passport,
    required this.country,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.age,
    required this.gender,
  });

  Map<String, dynamic> toMap() {
    return {
      "Fname": firstName,
      "Lname": lastName,
      "email": email,
      "password": password,
      "country": country,
      "gender": gender,
      "phone": phoneNumber,
      "passport": passport,
    };
  }

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      passport: map['passport'] as String,
      country: map['country'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      phoneNumber: map['phoneNumber'] as String,
      age: map['age'] as String,
      gender: map['gender'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Person.fromJson(String source) =>
      Person.fromMap(json.decode(source) as Map<String, dynamic>);
}
