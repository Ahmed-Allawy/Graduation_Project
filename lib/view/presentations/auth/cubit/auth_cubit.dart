import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
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

  // //this function for takeing the pic form the Gallery
  // pickImageGallery() async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //     if (image == null) {
  //       return;
  //     } else {
  //       final tempImage = File(image.path);
  //       img = tempImage;
  //       emit(ImageGallerySuccessful());
  //     }
  //   } on PlatformException catch (e) {
  //     emit(ImageGalleryError(e.toString()));
  //   }
  // }

  //this function for takeing the pic form the From Camera

  // pickImageCamera() async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: ImageSource.camera);
  //     if (image == null) {
  //       return;
  //     } else {
  //       //here we save the path of the image ;
  //       final tempImage = File(image.path);
  //       img = tempImage;
  //       emit(ImageCameraSuccessful());
  //     }
  //   } on PlatformException catch (e) {
  //     emit(ImageCameraError(e.toString()));
  //   }
  // }
}
