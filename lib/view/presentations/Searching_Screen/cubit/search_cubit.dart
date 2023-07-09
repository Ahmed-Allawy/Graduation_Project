// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/model/airports.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../shared/component/constants.dart';
import '../../../../model/persondata.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  int _people = 0;
  List<String> country = [];
  List<bool> gender = [];

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

  static SearchCubit get(BuildContext context) => BlocProvider.of(context);

  bool wayValue = true;

  List<String> classValue = ["Economy", "Business", "First Class"];
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

  Future<List<Airport>> fetchAirports() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('GET', Uri.parse('${uri}api/airport'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var body = await response.stream.bytesToString();
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
      List<String> responseList = json.decode(responseBody).cast<String>();
      return responseList;
    } else {
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

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
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

  pickImageCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) {
        return;
      } else {
        //here we save the path of the image ;
        final tempImage = File(image.path);
        img = tempImage;
        emit(ImageCameraSuccessful());
      }
    } on PlatformException catch (e) {
      emit(ImageCameraError(e.toString()));
    }
  }
}
