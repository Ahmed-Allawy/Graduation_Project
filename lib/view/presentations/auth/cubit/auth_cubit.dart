import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  //this is countery var used for the list
  String country = "Egypt";
  // this static function made to make it easyier to call the cubit functions in the UI
  static AuthCubit get(BuildContext context) => BlocProvider.of(context);
  // this section is used for chnage the scurity to the password
  bool scuretiyPassword = true;
  IconData suffixIcon = Icons.visibility;
  //this image for store the image in it
  File? img;

  void changeScureity() {
    scuretiyPassword = !scuretiyPassword;
    suffixIcon = scuretiyPassword ? Icons.visibility : Icons.visibility_off;
    emit(ScurityState());
  }

  void changeCountrey(String c) {
    country = c;
    emit(ChangeCountry());
  }
}
