import 'dart:convert';

class User {
  String fname;
  String lname;
  String country;
  String phone;
  String email;
  String password;

  User({
    required this.fname,
    required this.lname,
    required this.country,
    required this.phone,
    required this.email,
    required this.password,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      fname: map['Fname'],
      lname: map['Lname'],
      country: map['country'],
      phone: map['phone'],
      email: map['email'],
      password: map['password'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Fname': fname,
      'Lname': lname,
      'country': country,
      'phone': phone,
      'email': email,
      'password': password,
    };
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
