part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class ScurityState extends AuthState {}

// class ImageCameraSuccessful extends AuthState {}

// class ImageCameraError extends AuthState {
//   final String error;
//   ImageCameraError(this.error);
// }

// class ImageGallerySuccessful extends AuthState {}

// class ImageGalleryError extends AuthState {
//   final String error;
//   ImageGalleryError(this.error);
// }
