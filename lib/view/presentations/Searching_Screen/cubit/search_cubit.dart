// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/model/airports.dart';

import 'package:graduation/view/presentations/Searching_Screen/pics_screen.dart';
import 'package:graduation/view/shared/component/helperfunctions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../shared/component/components.dart';

import '../../../shared/component/constants.dart';
import '../../../../model/persondata.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  static SearchCubit get(BuildContext context) => BlocProvider.of(context);

  bool value = true;

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

    List<Map<String, dynamic>> modifiedPersons = persons.map((person) {
      return {
        "Fname": person.firstName,
        "Lname": person.lastName,
        "email": person.email,
        "password": person.password,
        "country": person.nationality,
        "gender": person.gender,
        "phone": person.phoneNumber,
        "passport": person.passport,
      };
    }).toList();

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
    value = val;
    emit(ChangeWays());
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

  void addMorePerson() {
    personFields.add(buildPersonFields());
    if (personFields.length > 1) {
      showUndoButton = true;
    }
    emit(AddPersonField());
  }

  void removePerson() {
    personFields.removeLast();
    if (personFields.length < 2) {
      showUndoButton = false;
    }
    emit(RemovePersonField());
  }

  void sumbit(BuildContext context) async {
    for (var widget in personFields) {
      final formKey = widget.key as GlobalKey<FormState>;
      if (widget is Form) {
        Widget formChild = widget.child;
        if (formChild is Column) {
          List<Widget> columnChildren = formChild.children;

          int currentintex = 0;
          Person newperson = Person(
              firstName: "firstName",
              lastName: "lastName",
              nationality: "nationality",
              email: "email",
              phoneNumber: "phoneNumber",
              age: "age",
              gender: "gender",
              passport: '',
              password: '');
          for (var childWidget in columnChildren) {
            if (childWidget is Container &&
                childWidget.child is TextFormField) {
              TextFormField textFormField = childWidget.child as TextFormField;

              String textValue = textFormField.controller!.text;
              if (currentintex == 0) {
                newperson.firstName = textValue;
              }
              if (currentintex == 1) {
                newperson.lastName = textValue;
              }
              if (currentintex == 2) {
                newperson.passport = textValue;
              }
              if (currentintex == 3) {
                newperson.nationality = textValue;
              }
              if (currentintex == 4) {
                newperson.email = textValue;
              }
              if (currentintex == 5) {
                newperson.password = textValue;
              }
              if (currentintex == 6) {
                newperson.age = textValue;
              }
              if (currentintex == 7) {
                newperson.gender = textValue;
              }
              currentintex++;
            } else if (childWidget is SizedBox &&
                childWidget.child is IntlPhoneField) {
              IntlPhoneField phoneField = childWidget.child as IntlPhoneField;

              String phoneNumber = phoneField.controller!.text;
              newperson.phoneNumber = phoneNumber;
            }
          }
          persons.add(newperson);
        }

        if (formKey.currentState!.validate()) {
          nextScreenRep(
              context,
              PicScreen(
                token: tokens,
                person: persons,
              ));
        }
      }
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
