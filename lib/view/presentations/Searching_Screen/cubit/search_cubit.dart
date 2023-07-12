// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/model/airports.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../../model/flight.dart';
import '../../../shared/component/constants.dart';
import '../../../../model/persondata.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  int _people = 0;
  List<String> userId = [];
  List<String> country = [];
  List<bool> gender = [];
  List<Flight> flights = [];
  String classid = "";
  double price = 0;

  int get people => _people;

  SearchCubit() : super(SearchInitial());

  List<String> _initializeCountryList() {
    return List.generate(_people, (index) => "Egypt");
  }

  List<bool> _initalizeGenderList() {
    return List.generate(_people, (index) => true);
  }

  void updatePeople(int value) {
    _people = value;
    country = _initializeCountryList();
    gender = _initalizeGenderList();
    emit(ChangePeople());
  }

  void updateUserId(List<String> uids) {
    userId.addAll(uids);
  }

  void updateclassid(String flightid) {
    classid = flightid;
  }

  void updateprice(double price) {
    price = price;
  }

  void setFlights(List<Flight> newFlights) {
    flights = newFlights;
  }

  static SearchCubit get(BuildContext context) => BlocProvider.of(context);

  bool wayValue = true;

  List<String> classValue = ["economi", "business", "first"];
  int classindex = 0;
  bool flexable = false;

  File? img;

  //used for the second searching screen
  List<Widget> personFields = [];
  List<Person> persons = [];
  List<String> tokens = [];
  bool showUndoButton = false;
  void clearPersons() {
    persons.clear();
  }

  List<Airport> countries = [];

  Future<List<Flight>> getAllFlightCoustom(String airportFrom, String airportTo,
      String dateFrom, String dateTo, String flightClass, int num) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('${uri}api/flight/from-to-elastic-date-class-no'));
    request.body = json.encode({
      "airportFrom": airportFrom,
      "airportTo": airportTo,
      "dateFrom": dateFrom,
      "dateTo": dateTo,
      "class": flightClass,
      "no": num
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var body = await response.stream.bytesToString();
      List<dynamic> jsonList = jsonDecode(body);
      List<Flight> flight =
          jsonList.map((json) => Flight.fromJson(json)).toList();
      emit(GetAllFligthCustomeSuccssful());

      return flight;
    } else {
      emit(GetAllFligthCustomeerror(response.stream.toString()));
      return [];
    }
  }

  Future<List<Flight>> getallflight(String airportFrom, String airoportTo,
      String date, String flightclass, int num) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'http://18.204.219.211:3000/api/flight/from-to-date-class-no'));
    request.body = json.encode({
      "airportFrom": airportFrom,
      "airportTo": airoportTo,
      "date": date,
      "class": flightclass,
      "no": num
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String body = await response.stream.bytesToString();
      List<dynamic> jsonList = jsonDecode(body);
      List<Flight> flight =
          jsonList.map((json) => Flight.fromJson(json)).toList();
      emit(GetAllFligthSuccssful());
      return flight;
    } else {
      emit(GetAllFligtherror(response.stream.toString()));
      return [];
    }
  }

  Future<List<Airport>> fetchAirports() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('GET', Uri.parse('${uri}api/airport'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String body = await response.stream.bytesToString();

      List<dynamic> jsonList = jsonDecode(body);
      List<Airport> c = jsonList.map((json) => Airport.fromJson(json)).toList();

      return c;
    } else {
      return [];
    }
  }

  Future<List<String>> sendClients() async {
    var headers = {'Content-Type': 'application/json'};

    List<Map<String, dynamic>> modifiedPersons =
        persons.map((person) => person.toMap()).toList();

    var request =
        http.Request('POST', Uri.parse('${uri}api/user/addMultipleClients'));

    request.body = json.encode(modifiedPersons);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      var jsonResponse = jsonDecode(responseBody);
      List<String> clientIds = jsonResponse['clients'].cast<String>();
      print(clientIds);
      emit(SendMultibleUsers());
      return clientIds;
    } else {
      String responseBody = await response.stream.bytesToString();
      print(responseBody);
      return [];
    }
  }

  void sumbitCountery(item, TextEditingController controller) {
    controller.text = item.name;
    emit(ChangeCountery());
  }

  void changeValues(val) {
    wayValue = val;
    emit(ChangeWays());
  }

  void changeClas(
    val,
  ) {
    classindex = classValue.indexOf(val);
    emit(ChangeClass());
  }

  void changeGender(val, int index) {
    gender[index] = val;
    emit(ChangeGender());
  }

  void changeFlexable(val) {
    flexable = val;
    emit(ChangeFlexable());
  }

  void changeCountrey(String c, int index) {
    country[index] = c;
    emit(ChangeCountry());
  }

  DateTime selectedDate = DateTime.now();
  DateTime beforeDate = DateTime.now();
  DateTime afterDate = DateTime.now();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;

      beforeDate = selectedDate.subtract(const Duration(days: 3));
      afterDate = selectedDate.add(const Duration(days: 3));
      emit(ChangeDate());
    }
  }

  void sumbit(
      BuildContext context,
      int people,
      List<TextEditingController> firstnames,
      List<TextEditingController> lastNames,
      List<TextEditingController> passports,
      List<TextEditingController> nationalitys,
      List<TextEditingController> emails,
      List<TextEditingController> passwords,
      List<TextEditingController> phonenumbers,
      List<TextEditingController> ages,
      List<TextEditingController> genders) {
    for (int i = 0; i < people; i++) {
      Person newperson = Person(
          firstName: firstnames[i].text,
          lastName: lastNames[i].text,
          passport: passports[i].text,
          country: nationalitys[i].text,
          email: emails[i].text,
          password: passwords[i].text,
          phoneNumber: phonenumbers[i].text,
          age: ages[i].text,
          gender: genders[i].text);
      persons.add(newperson);
    }
  }

  Future<bool> pickImageCamera() async {
    bool isFase = false;
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) {
        return false;
      } else {
        Uint8List imageBytes = await image.readAsBytes();

        print('++++++++++++++++++++++this is tempImage :$imageBytes');
        String imageBase64 = base64.encode(imageBytes);
        String header = 'data:image/jpeg;base64,';
        //here we save the path of the image ;

        sendImage((header + imageBase64)).then((value) {
          print('value from flask is : $value');
          isFase = value;
        });

        emit(ImageCameraSuccessful());

        return isFase;
      }
    } on PlatformException catch (e) {
      emit(ImageCameraError(e.toString()));
      return false;
    }
  }

  Future<bool> sendImage(imageBase) async {
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('POST', Uri.parse('http://10.0.2.2:5000/capture'));
    //here I send the password and the phone number for login by passing them to the body
    var obj = {
      'dataURL': imageBase,
    };

    request.body = json.encode(obj);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    // Check the status code and decode the response body
    if (response.statusCode == 200) {
      // Read the response body as a string
      print("grgrgrgfgdfgdgdgrf-------------------------");
      // Save the token to shared preferences or some other storage
      String output = await response.stream.bytesToString();

      return json.decode(output)['isFace'];
    } else if (response.statusCode == 400) {
      print("+++++++++++++++++++++++++++++++++++jajajajjajajajjaajjajajajaja");
      return false;
    } else {
      return false;
    }
  }
}
